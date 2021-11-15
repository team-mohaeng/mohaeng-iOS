//
//  FeedDetailViewController.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/05.
//

import UIKit
import Kingfisher

enum FeedDetail {
    case community
    case myDrawer
}

class FeedDetailViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var feedDetailCollectionView: UICollectionView!
    private var refreshControl = UIRefreshControl()
    private var previousController: FeedDetail = .myDrawer
    
    // MARK: - Properties
    
    private var allFeed: FeedResponse = FeedResponse(isNew: false, hasFeed: 0, userCount: 0, feeds: [Feed]())
    private var myFeed: [Feed] = []
    private var selectedContents: IndexPath = IndexPath(row: 0, section: 0)
    private var year: Int?
    private var month: Int?
    private var currentPostId = 0
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerXib()
        setDelegation()
        addObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initNavigationBar()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        switch previousController {
        case .community:
            navigationItem.title = "피드 둘러보기"
        case .myDrawer:
            navigationItem.title = "내 서랍장"
        }
        navigationController?.initWithBackButton()
    }
    
    private func registerXib() {
        feedDetailCollectionView.register(UINib(nibName: Const.Xib.Name.feedDetailCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.feedDetailCollectionViewCell)
        feedDetailCollectionView.register(FeedDetailCollectionViewCell.self, forCellWithReuseIdentifier: "FDCollectionViewCell")
    }
    
    private func setDelegation() {
        feedDetailCollectionView.delegate = self
        feedDetailCollectionView.dataSource = self
        feedDetailCollectionView.layoutIfNeeded()
        feedDetailCollectionView.scrollToItem(at: selectedContents, at: .top, animated: true)
        feedDetailCollectionView.refreshControl = refreshControl
        feedDetailCollectionView.refreshControl?.addTarget(self, action: #selector(getFeeds), for: .valueChanged)
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(presentStickerViewController),
                                            name: Notification.Name("PlusButtonDidTap"),
                                            object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name("stickerButtonDidTap"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name("DeleteButtonDidTap"), object: nil)
    }
    
    func setData(feeds: FeedResponse) {
        allFeed = feeds
    }
    
    func setMyDrawer(feeds: [Feed], year: Int?, month: Int?) {
        myFeed = feeds
        self.year = year
        self.month = month
    }

    func setPreviousController(viewController: FeedDetail) {
        previousController = viewController
    }
    
    func setSelectedContentsIndexPath(indexPath: IndexPath) {
        selectedContents = indexPath
    }
    
    @objc func reloadCollectionView() {
        switch previousController {
        case .community:
            getFeeds()
        case .myDrawer:
            if let year = year,
               let month = month {
                getMyDrawer(year: year, month: month)
            }
        }
    }
    
    @objc func presentStickerViewController(postId: NSNotification) {
        let storyboard = UIStoryboard(name: Const.Storyboard.Name.sticker, bundle: nil)
        guard let stickerViewController = storyboard.instantiateViewController(identifier: Const.ViewController.Identifier.sticker) as? StickerViewController else { return }
        stickerViewController.modalPresentationStyle = .overCurrentContext
        stickerViewController.modalTransitionStyle = .crossDissolve
        
        if let postId = postId.object as? Int {
            stickerViewController.postId = postId
        }
        tabBarController?.present(stickerViewController, animated: false, completion: nil)
    }
    
}

// MARK: - UICollectionViewDataSource

extension FeedDetailViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch previousController {
        case .myDrawer:
            return myFeed.count
        case .community:
            return allFeed.feeds.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = feedDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "FDCollectionViewCell", for: indexPath) as? FeedDetailCollectionViewCell else { return UICollectionViewCell() }
        
        cell.delegate = self
        
        switch previousController {
        case .myDrawer:
            cell.setData(feed: myFeed[indexPath.row], viewController: .myDrawer)
        case .community:
            cell.setData(feed: allFeed.feeds[indexPath.row], viewController: .community)
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width
        let imageHeight: CGFloat = width
        var baseHeight: CGFloat = UIDevice.current.hasNotch ? (588 / 812) * UIScreen.main.bounds.height : 588
        let maximumHeight: CGFloat = (672 / 812) * UIScreen.main.bounds.height
        let dummyCell = FeedDetailCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: maximumHeight))

        switch previousController {
        case .community:
            baseHeight = allFeed.feeds[indexPath.row].image.isEmpty ? baseHeight - imageHeight : baseHeight
            dummyCell.setData(feed: allFeed.feeds[indexPath.row], viewController: .community)
        case .myDrawer:
            baseHeight = myFeed[indexPath.row].image.isEmpty ? baseHeight - imageHeight : baseHeight
            dummyCell.setData(feed: myFeed[indexPath.row], viewController: .myDrawer)
        }
        dummyCell.layoutIfNeeded()

        let contentsHeight = dummyCell.getDynamicContentsHeight()
        let collectionViewHeight = dummyCell.getDynamicCollectionViewHeight()
        baseHeight = baseHeight < 0 ? 300 : baseHeight
        return CGSize(width: width, height: baseHeight + contentsHeight + collectionViewHeight)
    }
    
}

extension FeedDetailViewController {
    @objc func getFeeds() {
        FeedAPI.shared.getAllFeed { response in
            switch response {
            case .success(let data):
                if let data = data as? FeedResponse {
                    self.allFeed = data
                    self.feedDetailCollectionView.reloadData()
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

extension FeedDetailViewController {
    
    func getMyDrawer(year: Int, month: Int) {
        FeedAPI.shared.getMyDrawer(year: year, month: month) { response in
            switch response {
            case .success(let data):
                if let data = data as? [Feed] {
                    self.myFeed = data
                    self.feedDetailCollectionView.reloadData()
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

extension FeedDetailViewController: TrashReportButtonProtocol {
    func touchTrashButton(_ button: UIButton, postId: Int) {
        let deletePopUp = PopUpViewController()
        deletePopUp.modalTransitionStyle = .crossDissolve
        deletePopUp.modalPresentationStyle = .overCurrentContext
        deletePopUp.popUpUsage = .twoButtonNoImage
        deletePopUp.popUpActionDelegate = self

        currentPostId = postId
        self.tabBarController?.present(deletePopUp, animated: true, completion: nil)
        deletePopUp.setText(title: "삭제하기", description: "안부를 정말 삭제할거야?", buttonTitle: "삭제")
    }
    
    func touchReportButton(_ button: UIButton, postId: Int) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let reportAction = UIAlertAction(title: "신고하기", style: .destructive) { _ in
            self.postReport(id: postId)
        }
        actionSheet.addAction(reportAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.Grey3, forKey: "titleTextColor")
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension FeedDetailViewController: PopUpActionDelegate {
    func touchGreyButton(button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func touchYellowButton(button: UIButton) {
        deletePost(postId: currentPostId)
        self.dismiss(animated: true, completion: nil)
    }
}

extension FeedDetailViewController {
    
    func postReport(id: Int) {
        FeedAPI.shared.postReport(id: id) { response in
            switch response {
            case .success(let data):
                if let data = data as? String {
                    self.showToast(message: data, font: .spoqaHanSansNeo(size: 12))
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
    
    func deletePost(postId: Int) {
        FeedAPI.shared.deleteMyPost(postId: postId) { response in
            switch response {
            case .success(let data):
                if let data = data as? String {
                    self.showToast(message: data, font: .spoqaHanSansNeo(size: 12))
                    NotificationCenter.default.post(name: NSNotification.Name("DeleteButtonDidTap"), object: nil)
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
