//
//  FeedViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit
import SnapKit
import Then

class FeedViewController: UIViewController {
    
    // MARK: - Properties
    
    /// dummy data
    private var allFeeds: FeedResponse = FeedResponse(isNew: false, hasFeed: 0, userCount: 0, feeds: [Feed]())
    
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
    
    private var feedUserCountLabel = UILabel().then {
        $0.font = UIFont.gmarketFont(weight: .medium, size: 18)
        $0.numberOfLines = 2
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
    
    private var refreshControl = UIRefreshControl()

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
        getFeeds()
        self.navigationController?.isNavigationBarHidden = true
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
        feedCollectionView.backgroundView = UIView()
        feedCollectionView.backgroundView?.addSubview(headerView)
        
        feedBackgroundFrame.backgroundColor = .white
        feedBackgroundFrame.makeRounded(radius: 24)
    
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
    
        allFeeds = feed
        feedCollectionView.reloadData()
        if let userCount = feed.userCount {
            if userCount > 10 {
                feedUserCountLabel.text = "오늘은 \(userCount)개의\n안부가 남겨졌어요"
            } else {
                feedUserCountLabel.text = userCount > 10 ? "오늘은 \(userCount)개의\n안부가 남겨졌어" : "오늘 하루는 어땠어?\n안부를 기록하고 둘러봐!"
            }
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
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedDetailStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.feedDetail, bundle: nil)
        guard let feedDetailViewController = feedDetailStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.feedDetail) as? FeedDetailViewController else { return }
        
        feedDetailViewController.setData(feeds: allFeeds)
        feedDetailViewController.setPreviousController(viewController: .community)
        feedDetailViewController.setSelectedContentsIndexPath(indexPath: indexPath)
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
                                        내일 챌린지를 인증하고하고 찾아와줘~
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
    @objc func getFeeds() {
        FeedAPI.shared.getAllFeed { response in
            switch response {
            case .success(let data):
                if let data = data as? FeedResponse {
                    self.updateData(feed: data)
                    self.refreshControl.endRefreshing()
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
