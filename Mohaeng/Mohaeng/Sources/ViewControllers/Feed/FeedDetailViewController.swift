//
//  FeedDetailViewController.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/05.
//

import UIKit
import Kingfisher

class FeedDetailViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var feedDetailCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var allFeed: FeedResponse = FeedResponse(isNew: false, hasFeed: 0, userCount: 0, feeds: [Feed]())
    private var selectedContents: IndexPath = IndexPath(row: 0, section: 0)
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initNavigationBar()
        registerXib()
        setDelegation()
        addObserver()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        navigationItem.title = "피드 둘러보기"
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
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(presentStickerViewController),
                                            name: Notification.Name("PlusButtonDidTap"),
                                            object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name("stickerButtonDidTap"), object: nil)
    }
    
    func setData(feeds: FeedResponse) {
        allFeed = feeds
    }

    func setSelectedContentsIndexPath(indexPath: IndexPath) {
        selectedContents = indexPath
    }
    
    @objc func reloadCollectionView() {
        getFeeds()
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
        return allFeed.feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = feedDetailCollectionView.dequeueReusableCell(withReuseIdentifier: "FDCollectionViewCell", for: indexPath) as? FeedDetailCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(feed: allFeed.feeds[indexPath.row])
        
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
        
        let dummyImage = UIImageView()
        dummyImage.updateServerImage(allFeed.feeds[indexPath.row].image)
        let baseHeight: CGFloat = allFeed.feeds[indexPath.row].image.isEmpty ? 588 - imageHeight : 588
        let maximumHeight: CGFloat = (674 / 812) * UIScreen.main.bounds.height
        
        let dummyCell = FeedDetailCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: maximumHeight))
        dummyCell.setData(feed: allFeed.feeds[indexPath.row])
        dummyCell.layoutIfNeeded()
        
        let contentsHeight = dummyCell.getDynamicContentsHeight()
        let collectionViewHeight = dummyCell.getDynamicCollectionViewHeight()
        
        return CGSize(width: width, height: baseHeight + contentsHeight + collectionViewHeight)
    }
    
}

extension FeedDetailViewController {
    func getFeeds() {
        FeedAPI.shared.getAllFeed { response in
            switch response {
            case .success(let data):
                if let data = data as? FeedResponse {
                    self.allFeed = data
                    self.feedDetailCollectionView.reloadData()
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
