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
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var feedDummy: FeedResponse = FeedResponse(isNew: false, hasFeed: 0, userCount: 0, feeds: [Feed]())
    
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
        feedCollectionView.register(UINib(nibName: Const.Xib.Name.feedDetailCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.feedDetailCollectionViewCell)
        feedCollectionView.register(FeedDetailCollectionViewCell.self, forCellWithReuseIdentifier: "FDCollectionViewCell")
    }
    
    private func setDelegation() {
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(presentStickerViewController),
                                            name: Notification.Name("PlusButtonDidTap"),
                                            object: nil)
    }
    
    @objc func presentStickerViewController() {
        let storyboard = UIStoryboard(name: Const.Storyboard.Name.sticker, bundle: nil)
        let stickerViewController = storyboard.instantiateViewController(identifier: Const.ViewController.Identifier.sticker)
        stickerViewController.modalPresentationStyle = .overCurrentContext
        stickerViewController.modalTransitionStyle = .crossDissolve
        
        tabBarController?.present(stickerViewController, animated: false, completion: nil)
    }
    
}

// MARK: - UICollectionViewDataSource

extension FeedDetailViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedDummy.feeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "FDCollectionViewCell", for: indexPath) as? FeedDetailCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(feed: feedDummy.feeds[indexPath.row])
        
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
        
        let baseHeight: CGFloat = feedDummy.feeds[indexPath.row].image.isEmpty ? 588 - imageHeight : 588
        let maximumHeight: CGFloat = (674 / 812) * UIScreen.main.bounds.height
        
        let dummyCell = FeedDetailCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: maximumHeight))
        dummyCell.setData(feed: feedDummy.feeds[indexPath.row])
        dummyCell.layoutIfNeeded()
        
        let contentsHeight = dummyCell.getDynamicContentsHeight()
        let collectionViewHeight = dummyCell.getDynamicCollectionViewHeight()
        
        return CGSize(width: width, height: baseHeight + contentsHeight + collectionViewHeight)
    }
    
}
