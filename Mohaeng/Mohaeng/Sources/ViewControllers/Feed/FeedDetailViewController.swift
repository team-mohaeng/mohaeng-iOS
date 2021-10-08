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
    
    var feedDummy: FeedInfo = FeedInfo(isNew: true, hasFeed: 0, userCount: 50, feed: [
                                        Feed(postID: 0, course: "뽀득뽀득 세균 퇴치", challenge: 3, image: "img", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 승찬이 개때리러간다 ㅋㅋ ", nickname: "초야초야", year: "2021", month: "8", day: "22", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false),
                                        Feed(postID: 0, course: "나는야 지구촌 촌장", challenge: 1, image: "", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 덤덤댄스 릴스 췄당 ㅋㅋ", nickname: "정초이", year: "2021", month: "8", day: "21", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5), Emoji(emojiID: 2, emojiCount: 5), Emoji(emojiID: 3, emojiCount: 5), Emoji(emojiID: 4, emojiCount: 99), Emoji(emojiID: 5, emojiCount: 99), Emoji(emojiID: 6, emojiCount: 99)], myEmoji: 0, isReport: true, isDelete: false),
                                        Feed(postID: 0, course: "초급 사진가", challenge: 2, image: "bgGraphicHappy", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 선선한 날씨에 산책했어요.", nickname: "뽈씨", year: "2021", month: "8", day: "20", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5), Emoji(emojiID: 1, emojiCount: 5), Emoji(emojiID: 2, emojiCount: 5), Emoji(emojiID: 3, emojiCount: 5), Emoji(emojiID: 4, emojiCount: 99), Emoji(emojiID: 4, emojiCount: 99) ], myEmoji: 0, isReport: true, isDelete: false),
                                        Feed(postID: 0, course: "거침없이 하이킥", challenge: 2, image: "", mood: 2, content: "초이초이 ㅋㅋ", nickname: "김승찬", year: "2021", month: "8", day: "19", weekday: "일", emoji: [], myEmoji: 0, isReport: true, isDelete: false)])
    
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
        return feedDummy.feed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "FDCollectionViewCell", for: indexPath) as? FeedDetailCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(feed: feedDummy.feed[indexPath.row])
        
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
        
        let baseHeight: CGFloat = feedDummy.feed[indexPath.row].image.isEmpty ? 588 - imageHeight : 588
        let maximumHeight: CGFloat = (674 / 812) * UIScreen.main.bounds.height
        
        let dummyCell = FeedDetailCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: maximumHeight))
        dummyCell.setData(feed: feedDummy.feed[indexPath.row])
        dummyCell.layoutIfNeeded()
        
        let contentsHeight = dummyCell.getDynamicContentsHeight()
        let collectionViewHeight = dummyCell.getDynamicCollectionViewHeight()
        
        return CGSize(width: width, height: baseHeight + contentsHeight + collectionViewHeight)
    }
    
}
