//
//  FeedViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

import SnapKit
import Then
import Lottie

class FeedViewController: UIViewController {
    
    // MARK: - Properties
    
    /// dummy data
    private var allFeeds: FeedResponse = FeedResponse(isNew: false, hasFeed: 0, userCount: 0, feeds: [Feed]())
    private var currentData: FeedResponse = FeedResponse(isNew: false, hasFeed: 0, userCount: 0, feeds: [Feed]())
    private var currentPage = 0
    private var isLast = false
    private var cachedPages: [Int] = []
    
    enum Size {
        static let FeedCollectionViewTopConstraint: CGFloat = 167
        static let FeedRoundingTopViewHeightConstraint: CGFloat = 20
        static let HeadViewHeightConstraint: CGFloat = 200
        static let minimumHeightWithButtonVisible: CGFloat = 30
    }
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var floatingTopButton: UIButton!
    private lazy var loadingView = AnimationView(name: "loading").then {
        $0.contentMode = .scaleAspectFill
        $0.loopMode = .loop
        $0.play()
        $0.isHidden = true
        $0.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        $0.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
    }
    
    private var feedUserCountLabel = UILabel().then {
        $0.font = UIFont.gmarketFont(weight: .medium, size: 18)
        $0.numberOfLines = 0
    }
    
    private var feedBackgroundFrame = UIView().then {
        $0.frame = CGRect(x: 0, y: Size.FeedCollectionViewTopConstraint, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 100)
    }
    
    private var headerGraphicImageView = UIImageView().then {
        $0.image = Const.Image.feedGraphic
    }
    
    private var headerView: FeedHeaderView = {
        guard let nib = UINib(nibName: Const.Xib.Name.feedHeaderView, bundle: nil).instantiate(withOwner: self, options: nil).first as? FeedHeaderView else { return FeedHeaderView() }
        return nib
    }()
    
    private var refreshControl = UIRefreshControl().then {
        $0.tintColor = .Yellow4
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setDelegation()
        registerXib()
        initAtrributes()
        setupAutoLayout()
        addObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        getFeeds(page: currentPage)
    }
    
    override func viewWillLayoutSubviews() {
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        headerView.setHeaderData(hasNewContents: allFeeds.isNew ?? false, contents: allFeeds.userCount ?? 0)
        setHeaderViewDelegate()
        
        feedCollectionView.insertSubview(feedBackgroundFrame, at: 0)
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initTransparentNavBar()
    }
    
    private func registerXib() {
        feedCollectionView.register(UINib(nibName: Const.Xib.Name.feedCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.feedCollectionViewCell)
    }
    
    private func setDelegation() {
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        feedCollectionView.refreshControl = refreshControl
        feedCollectionView.refreshControl?.addTarget(self, action: #selector(getFeeds), for: .valueChanged)
    }
    
    private func setHeaderViewDelegate() {
        headerView.delegate = self
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(getFeeds), name: NSNotification.Name("RefreshFeedCollectionView"), object: nil)
    }
    
    private func initAtrributes() {
        view.addSubview(loadingView)
        
        feedCollectionView.backgroundView = UIView()
        feedCollectionView.backgroundView?.addSubview(headerView)
        
        feedBackgroundFrame.backgroundColor = .white
        feedBackgroundFrame.makeRounded(radius: 24)
        feedBackgroundFrame.addShadowWithOpaqueBackground(opacity: 0.04, radius: 24)
        
        floatingTopButton.contentEdgeInsets = UIEdgeInsets(top: 0.01, left: 0, bottom: 0.01, right: 0)
        floatingTopButton.addShadowWithOpaqueBackground(opacity: 0.1, radius: 1)
    }
    
    private func setupAutoLayout() {
        view.addSubviews(feedBackgroundFrame, headerGraphicImageView, feedUserCountLabel)
        
        feedUserCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(feedBackgroundFrame.snp.top).offset(-18)
            $0.leading.equalToSuperview().offset(24)
        }
        
        headerGraphicImageView.snp.makeConstraints {
            $0.bottom.equalTo(feedBackgroundFrame.snp.top).offset(10)
            $0.trailing.equalToSuperview().inset(32)
        }
    }
    
    private func updateData(feed: FeedResponse) {
        if feed.feeds.isEmpty {
            isLast = true
            return
        }
        
        switch feedCollectionView.status {
        case .initial: // 초기 로드 상태
            allFeeds = feed
        case .refreshing: // refreshControl로 새로 고침 했을 때 삭제된 피드, 새로 들어온 피드 비교
            let diff = feed.feeds.difference(from: allFeeds.feeds)
            diff.forEach { differenceKind in
                switch differenceKind {
                case .remove(let offset, _, _):
                    allFeeds.feeds.remove(at: offset)
                case .insert(let offset, let element, _):
                    allFeeds.feeds.insert(element, at: offset)
                }
            }
        case .scrolled: // 페이징 처리할 때 호출됨. 이미 있는 데이터는 거르고 새로운 데이터만 추가함
            if cachedPages.filter({ $0 == currentPage }).count == 0 {
                allFeeds.feeds.append(contentsOf: feed.feeds)
            }
        }
        
        feedCollectionView.reloadData()
        
        if let userCount = feed.userCount {
            feedUserCountLabel.text = userCount > 10 ? "오늘은 \(userCount)개의\n안부가 남겨졌어" : "오늘 하루는 어때?\n네 안부가 궁금해!"
        }
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchFloatingTopButton(_ sender: Any) {
        let topOffset: CGPoint = .zero
        self.feedCollectionView.setContentOffset(topOffset, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension FeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFeeds.feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Name.feedCollectionViewCell, for: indexPath) as? FeedCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(data: allFeeds.feeds[indexPath.row])
        
        if indexPath.row == allFeeds.feeds.count - 1 && !isLast {
            currentPage += 1
            self.getFeeds(page: currentPage)
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedDetailStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.feedDetail, bundle: nil)
        guard let feedDetailViewController = feedDetailStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.feedDetail) as? FeedDetailViewController else { return }
        
        currentPage = indexPath.row / 15
        currentData.feeds = isLast ? Array(allFeeds.feeds[15 * currentPage...allFeeds.feeds.count - 1]) : Array(allFeeds.feeds[15 * currentPage...currentPage * 15 + 14])
        feedDetailViewController.setData(feeds: currentData)
        feedDetailViewController.setPreviousController(viewController: .community)
        feedDetailViewController.setSelectedContentsIndexPath(indexPath: indexPath, page: indexPath.row / 15)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(feedDetailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        changeHeaderViewOpacity()
        changeFloatingButtonOpacity()
    }
    
    func changeHeaderViewOpacity() {
        let offset = feedCollectionView.contentOffset.y
        let headViewAlphaPercent = (Size.HeadViewHeightConstraint - offset) / Size.HeadViewHeightConstraint
        let headerResourceAlphaPercent = (50 - offset) / 50
        
        headerView.alpha = headViewAlphaPercent
        statusBarView.alpha = headViewAlphaPercent
        headerGraphicImageView.alpha = headerResourceAlphaPercent
        feedUserCountLabel.alpha = headerResourceAlphaPercent
    }
    
    func changeFloatingButtonOpacity() {
        if feedCollectionView.contentOffset.y > Size.minimumHeightWithButtonVisible {
            UIView.animate(withDuration: 1.0) { [self] in
                floatingTopButton.alpha = 1.0
                floatingTopButton.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 1.0) { [self] in
                floatingTopButton.alpha = 0.0
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = width * (375 / 375)
        let cellHeight = cellWidth * (144 / 375)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Size.FeedCollectionViewTopConstraint + Size.FeedRoundingTopViewHeightConstraint, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}

// MARK: - HeaderViewDelegate

extension FeedViewController: HeaderViewDelegate {
   
    func touchMyDrawerButton() {
        let myDrawerStoryboard = UIStoryboard(name: Const.Storyboard.Name.myDrawer, bundle: nil)
        guard let myDrawerViewController = myDrawerStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.myDrawer) as? MyDrawerViewController else { return }
        
        myDrawerViewController.setWritingStatus(writingStatus: allFeeds.isNew ?? false)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(myDrawerViewController, animated: true)
    }
    
    func touchWritingButton() {
        let moodStoryboard = UIStoryboard(name: Const.Storyboard.Name.mood, bundle: nil)
        guard let moodViewController = moodStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.mood) as? MoodViewController else { return }
        
        switch allFeeds.hasFeed {
        case 0: // 작성 가능
            let navigationController = UINavigationController(rootViewController: moodViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        case 1: // 이미 작성
            let popUp = PopUpViewController()
            popUp.modalTransitionStyle = .crossDissolve
            popUp.modalPresentationStyle = .overCurrentContext
            popUp.popUpUsage = .noButton
            popUp.popUpActionDelegate = self
            self.tabBarController?.present(popUp, animated: true, completion: nil)
            popUp.setText(title: "오늘의 안부 작성 완료!",
                          description: """
                                        안부는 하루에 한 번만 작성할 수 있어.
                                        내일 챌린지를 인증하고 찾아와줘~
                                        """)
        case 2: // 챌린지 코스 시작 전
            let popUp = PopUpViewController()
            popUp.modalTransitionStyle = .crossDissolve
            popUp.modalPresentationStyle = .overCurrentContext
            popUp.popUpUsage = .noButton
            popUp.popUpActionDelegate = self
            self.tabBarController?.present(popUp, animated: true, completion: nil)
            popUp.setText(title: "선 챌린지, 후 안부!",
                          description: """
                                        이런, 아직 오늘의 챌린지 안했지?!
                                        오늘의 챌린지를 인증해야 작성할 수 있어
                                        """)
        default:
            return
        }
    }
    
}

// MARK: - SERVER CONNECT

extension FeedViewController {
    @objc
    func getFeeds(page: Int) {
        loadingView.isHidden = false
        let currentPage = feedCollectionView.contentOffset.y <= 0 ? 0 : currentPage
        FeedAPI.shared.getFeed(page: currentPage) { response in
            switch response {
            case .success(let data):
                if let data = data as? FeedResponse {
                    self.updateData(feed: data)
                    self.feedCollectionView.reloadData()
                    self.refreshControl.endRefreshing()
                    self.cachedPages.append(page)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        self.loadingView.isHidden = true
                    }
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}

extension FeedViewController: PopUpActionDelegate {
    
    func touchGreyButton(button: UIButton) {
        return
    }
    
    func touchYellowButton(button: UIButton) {
        return
    }
    
}

extension UICollectionView {
    
    enum Status {
        case refreshing
        case initial
        case scrolled
    }
    
    var status: Status {
        if self.contentOffset.y < 0 {
            return .refreshing
        } else if self.contentOffset.y == 0 {
            return .initial
        } else {
            return .scrolled
        }
            
    }
    
}
