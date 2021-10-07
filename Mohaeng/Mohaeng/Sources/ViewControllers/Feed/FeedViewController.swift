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
    var feedDummy: FeedInfo = FeedInfo(isNew: true, hasFeed: 0, userCount: 50, feed: [
                                                                                    Feed(postID: 0, course: "뽀득뽀득 세균 퇴치", challenge: 3, image: "imageUrl", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 승찬이 개때리러간다 ㅋㅋ ", nickname: "정초이", year: "2021", month: "8", day: "22", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false),
                                                                                    Feed(postID: 0, course: "나는야 지구촌 촌장", challenge: 1, image: "imageUrl", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 덤덤댄스 릴스 췄당 ㅋㅋ", nickname: "정초이", year: "2021", month: "8", day: "21", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false),
                                                                                    Feed(postID: 0, course: "초급 사진가", challenge: 2, image: "imageUrl", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 선선한 날씨에 산책했어요. 윤예지 정초이 어쩌구 저쩌구 메롱 야호", nickname: "윤예지", year: "2021", month: "8", day: "20", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false),
                                                                                    Feed(postID: 0, course: "거침없이 하이킥", challenge: 2, image: "imageUrl", mood: 2, content: "초이초이 ㅋㅋ", nickname: "김승찬", year: "2021", month: "8", day: "19", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false),
                                                                                    Feed(postID: 0, course: "초급 사진가", challenge: 2, image: "imageUrl", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 선선한 날씨에 산책했어요. 윤예지 정초이 어쩌구 저쩌구 메롱 야호", nickname: "윤예지", year: "2021", month: "8", day: "20", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false)])
                                                                                    
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
    var feedBackgroundFrame: UIView = UIView(frame: CGRect(x: 0, y: Size.FeedCollectionViewTopConstraint, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 100))
    var handImageView = UIImageView()
    var headerView: FeedHeaderView = {
        guard let nib = UINib(nibName: Const.Xib.Name.feedHeaderView, bundle: nil).instantiate(withOwner: self, options: nil).first as? FeedHeaderView else { return FeedHeaderView() }
        return nib
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initNavigationBar()
        setDelegation()
        registerXib()
        initAtrributes()
        initHandLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        headerView.setHeaderData(hasNewContents: feedDummy.isNew, contents: feedDummy.feed.count)
        setHeaderViewDelegate()
        
        self.feedCollectionView.insertSubview(self.feedBackgroundFrame, at: 0)
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
    }
    
    private func initAtrributes() {
        feedCollectionView.backgroundView = UIView()
        feedCollectionView.backgroundView?.addSubview(headerView)
        
        feedBackgroundFrame.backgroundColor = .white
        feedBackgroundFrame.makeRounded(radius: 24)
    
        floatingTopButton.contentEdgeInsets = UIEdgeInsets(top: 0.01, left: 0, bottom: 0.01, right: 0)
        floatingTopButton.layer.shadowOffset = CGSize(width: 2, height: 3)
        floatingTopButton.layer.shadowColor = UIColor.black.cgColor
        floatingTopButton.layer.shadowOpacity = 0.1
        
        handImageView.image = Const.Image.imgHand
    }
    
    private func setHeaderViewDelegate() {
        headerView.delegate = self
    }
    
    private func initHandLayout() {
        view.addSubviews(handImageView, feedBackgroundFrame)
        
        handImageView.snp.makeConstraints {
            $0.bottom.equalTo(feedBackgroundFrame.snp.top).offset(10)
            $0.trailing.equalToSuperview().offset(-32)
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
        return feedDummy.feed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Name.feedCollectionViewCell, for: indexPath) as? FeedCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setData(data: feedDummy.feed[indexPath.row])
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedDetailStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.feedDetail, bundle: nil)
        guard let feedDetailViewController = feedDetailStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.feedDetail) as? FeedDetailViewController else { return }
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(feedDetailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let headViewAlphaPercent = (Size.HeadViewHeightConstraint - offset) / Size.HeadViewHeightConstraint
        let handAlphaPercent = (10 - offset) / 10
        
        if offset < Size.HeadViewHeightConstraint {
            headerView.alpha = max(headViewAlphaPercent, 0.3)
            statusBarView.alpha = headViewAlphaPercent
            handImageView.alpha = handAlphaPercent
        }
        
        if feedCollectionView.contentOffset.y > Size.minimumHeightWithButtonVisible {
            UIView.animate(withDuration: 1.0) {
                self.floatingTopButton.alpha = 1.0
                self.floatingTopButton.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 1.0) {
                self.floatingTopButton.alpha = 0.0
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
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(myDrawerViewController, animated: true)
    }
    
    func touchWritingButton() {
        let writingStoryboard = UIStoryboard(name: Const.Storyboard.Name.writing, bundle: nil)
        guard let writingViewController = writingStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.writing) as? WritingViewController else { return }
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(writingViewController, animated: true)
    }
    
}
