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
    
    var community = [Community(postID: 0, nickname: "", mood: 0, mainImage: "", likeCount: 0, content: "", hasLike: false, hashtags: [""], year: "", month: "", day: "", week: "")]
    var likeButtonClicked: Bool = true
    var isEnableWriting: Int = 0
    var moodStatus: Int = 0
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var floatingTopButton: UIButton!
    
    var headerView: FeedHeaderView = {
        guard let nib = UINib(nibName: "FeedHeaderView", bundle: nil).instantiate(withOwner: self, options: nil).first as? FeedHeaderView else { return FeedHeaderView() }
        return nib
    }()
    var feedBackgroundFrame: UIView = UIView(frame: CGRect(x: 0, y: 244, width: UIScreen.main.bounds.width, height: 224 * (64 / 2) + 200))
    var feedTitleLabel = UILabel()
    var filterView = UIView()
    var filterLabel = UILabel()
    var filterImageView = UIImageView()
    var disablePopUp: PopUpViewController = PopUpViewController()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        activityIndicator.hidesWhenStopped = false
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    var backgroundView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getAllFeed(sort: "like")
        initNavigationBar()
        initFrameViewLayout()
        setDelegation()
        registerXib()
        initAtrributes()
        addObserver()
        addFilterTouchEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllFeed(sort: "like")
        self.navigationController?.hideNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        headerView.frame = CGRect(x: 0, y: feedCollectionView.safeAreaInsets.top, width: UIScreen.main.bounds.width, height: (205 / 812) * UIScreen.main.bounds.height + UIScreen.main.bounds.height)
        self.feedCollectionView.insertSubview(self.feedBackgroundFrame, at: 0)
    }
    
    // MARK: - function
    
    private func initNavigationBar() {
        self.navigationController?.hideNavigationBar()
    }
    
    private func registerXib() {
        feedCollectionView.register(ContentsCollectionViewCell.self, forCellWithReuseIdentifier: Const.Xib.Identifier.contentsCollectionViewCell)
    }
    
    private func setDelegation() {
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
    }
    
    private func initAtrributes() {
        feedCollectionView.backgroundView = UIView()
        feedCollectionView.backgroundView?.addSubview(headerView)
        feedCollectionView.contentInset = .zero
        
        feedBackgroundFrame.backgroundColor = .white
        feedBackgroundFrame.makeRounded(radius: 24)
        
        feedTitleLabel.numberOfLines = 2
        feedTitleLabel.font = UIFont.spoqaHanSansNeo(weight: .bold, size: 16)
        feedTitleLabel.tintColor = UIColor.Black1Text
        feedTitleLabel.text = "오늘은 n명의 쟈기들이 \n행복을 기록했어요"
        
        filterLabel.text = "좋아요 순"
        filterLabel.textColor = .Black2Text
        filterLabel.font = UIFont.spoqaHanSansNeo(weight: .regular, size: 12)
        filterImageView.image = UIImage(named: "btnFilter")
        
        floatingTopButton.contentEdgeInsets = UIEdgeInsets(top: 0.01, left: 0, bottom: 0.01, right: 0)
        floatingTopButton.layer.shadowOffset = CGSize(width: 2, height: 3)
        floatingTopButton.layer.shadowColor = UIColor.black.cgColor
        floatingTopButton.layer.shadowOpacity = 0.1
    }
    
    private func initFrameViewLayout() {
        filterView.addSubviews(filterLabel, filterImageView)
        feedBackgroundFrame.addSubviews(feedTitleLabel, filterView)
        
        feedTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(38)
            $0.leading.equalToSuperview().offset(24)
        }
        
        filterView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.trailing.equalToSuperview().offset(-14)
            $0.width.equalTo(82)
            $0.height.equalTo(36)
        }
        
        filterLabel.snp.makeConstraints {
            $0.trailing.equalTo(filterImageView.snp.leading)
            $0.centerY.equalTo(filterView.snp.centerY)
        }
        
        filterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().offset(-9)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushToMyDrawerViewController), name: NSNotification.Name("myDrawerCilcked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushToMoodViewController), name: NSNotification.Name("writeHappinessClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(putLikeCount), name: NSNotification.Name("likeButtonClicked"), object: nil)
    }
    
    private func addPostFeedData(data: FeedData) {
        NotificationCenter.default.post(name: NSNotification.Name("sendServerData"), object: data)
    }
    
    private func addFilterTouchEvent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchFilterView(sender:)))
        filterView.addGestureRecognizer(tapGesture)
    }
    
    private func changeLabelName(label: UILabel, text: String) {
        label.text = text
    }
    
    private func attachActivityIndicator() {
        backgroundView.backgroundColor = UIColor.white
        self.view.addSubview(backgroundView)
        self.view.addSubview(self.activityIndicator)
    }
    
    private func detachActivityIndicator() {
        if self.activityIndicator.isAnimating {
            self.activityIndicator.stopAnimating()
        }
        self.backgroundView.removeFromSuperview()
        self.activityIndicator.removeFromSuperview()
    }
    
    private func updateData(data: FeedData) {
        self.community = data.community
        feedTitleLabel.text = "오늘은 \(data.community.count)명의 쟈기들이 \n행복을 기록했어요"
        feedCollectionView.reloadData()
        isEnableWriting = data.hasSmallSatisfaction
        self.detachActivityIndicator()
    }
    
    // MARK: - @IBAction Properties
    
    @objc func pushToMyDrawerViewController(notification: NSNotification) {
        let myDrawerStoryboard = UIStoryboard(name: Const.Storyboard.Name.myDrawer, bundle: nil)
        guard let nextVC = myDrawerStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.myDrawer) as? MyDrawerViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func pushToMoodViewController(notification: NSNotification) {
        // 0:소확행 작성 가능 1: 소확행 이미 작성, 2: 챌린지 시작 전, 3:챌린지 성공 전
        disablePopUp = PopUpViewController(nibName: Const.Xib.Name.popUp, bundle: nil)
        disablePopUp.modalPresentationStyle = .overCurrentContext
        disablePopUp.modalTransitionStyle = .crossDissolve
        switch isEnableWriting {
        case 0:
            let moodStoryboard = UIStoryboard(name: Const.Storyboard.Name.mood, bundle: nil)
            guard let nextVC = moodStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.mood) as? MoodViewController else { return }
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 1:
            moodStatus = 1
            disablePopUp.popUpUsage = .oneButton
            disablePopUp.popUpActionDelegate = self
            tabBarController?.present(disablePopUp, animated: true, completion: nil)
            
            disablePopUp.titleLabel.text = "쟈기, 이미 작성했잖아!"
            disablePopUp.descriptionLabel.text = "오늘은 행복한 일이 많았나보군.\n아쉽지만 하루에 하나만 쓸 수 있어.\n당신의 내일을 기대하도록 하지!"
            disablePopUp.pinkButton?.setTitle("알았어", for: .normal)
        case 2:
            moodStatus = 2
            disablePopUp.popUpUsage = .oneButtonWithClose
            disablePopUp.popUpActionDelegate = self
            tabBarController?.present(disablePopUp, animated: true, completion: nil)
            
            disablePopUp.titleLabel.text = "챌린지를 시작해보겠어?"
            disablePopUp.descriptionLabel.text = "소확행은 오늘의 챌린지를\n성공해야 작성할 수 있어.\n나와 함께 챌린지를 수행해보겠어?"
            disablePopUp.pinkButton?.setTitle("코스 선택하러 가기", for: .normal)
        case 3:
            moodStatus = 3
            disablePopUp.popUpUsage = .oneButtonWithClose
            disablePopUp.popUpActionDelegate = self
            tabBarController?.present(disablePopUp, animated: true, completion: nil)
            
            disablePopUp.titleLabel.text = "이런, 아직 작성할 수 없어!"
            disablePopUp.descriptionLabel.text = "소확행은 오늘의 챌린지를\n 성공해야 작성할 수 있어.\n나와 함께 챌린지를 수행해보겠어?"
            disablePopUp.pinkButton?.setTitle("오늘의 챌린지로 이동하기", for: .normal)
        default:
            break
        }
    }
    
    @objc func putLikeCount(notification: Notification) {
        if let likeInfo = notification.object as? LikeButtonInfo {
            if likeInfo.isButtonClicked {
                putFeedLike(postId: community[likeInfo.cellIndex].postID)
            } else {
                putFeedUnlike(postId: community[likeInfo.cellIndex].postID)
            }
        }
    }
    
    @objc func touchFilterView(sender: UITapGestureRecognizer) {
        if filterLabel.text == "좋아요 순" {
            changeLabelName(label: filterLabel, text: "최신 순")
            getAllFeed(sort: "date")
        } else {
            changeLabelName(label: filterLabel, text: "좋아요 순")
            getAllFeed(sort: "like")
        }
    }
    
    @IBAction func touchFloatingTopButton(_ sender: Any) {
        let topOffset = CGPoint(x: 0, y: 0)
        self.feedCollectionView.setContentOffset(topOffset, animated: true)
    }
}

extension FeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return community.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Name.contentsCollectionViewCell, for: indexPath) as? ContentsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.makeRounded(radius: 14)
        cell.setData(data: community[indexPath.row], viewController: .community)
        
        return cell
    }
    
}

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedDetailStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.feedDetail, bundle: nil)
        guard let feedDetailViewController = feedDetailStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.feedDetail) as? FeedDetailViewController else { return }
        
        feedDetailViewController.feedInfo = community[indexPath.row]
        self.navigationController?.pushViewController(feedDetailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let percent = (244 - offset)/244
        
        if offset < 245 {
            headerView.alpha = max(percent, 0.3)
            statusBarView.alpha = percent
        }
        
        if feedCollectionView.contentOffset.y > 10 {
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

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = width * (156/375)
        let cellHeight = cellWidth * (208/156)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 346, left: 22, bottom: 24, right: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}

extension FeedViewController: PopUpActionDelegate {
    func touchPinkButton(button: UIButton) {
        switch moodStatus {
        case 1:
            self.disablePopUp.dismiss(animated: true, completion: nil)
        case 2:
            let cousreStoryboard = UIStoryboard(name: Const.Storyboard.Name.courseLibrary, bundle: nil)
            guard let courseViewController = cousreStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.courseLibrary) as? CourseLibraryViewController else { return }
            
            courseViewController.doingCourse = false
            
            self.disablePopUp.dismiss(animated: true, completion: nil)
            self.navigationController?.pushViewController(courseViewController, animated: true)
        case 3:
            let challengeStoryboard = UIStoryboard(name: Const.Storyboard.Name.challenge, bundle: nil)
            guard let challengeViewController = challengeStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.challenge) as? ChallengeViewController else { return }
            
            self.disablePopUp.dismiss(animated: true, completion: nil)
            self.navigationController?.pushViewController(challengeViewController, animated: true)
        default:
            break
        }
    }
    
    func touchWhiteButton(button: UIButton) {
        return
    }
    
}

extension FeedViewController {
    
    func getAllFeed(sort: String) {
        self.attachActivityIndicator()
        FeedAPI.shared.getAllFeed(sort: sort) { (response) in
            switch response {
            case .success(let feeds):
                if let data = feeds as? FeedData {
                    self.updateData(data: data)
                    self.addPostFeedData(data: data)
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
            
        }
    }
    
    func putFeedLike(postId: Int) {
        FeedAPI.shared.putFeedLike(postId: postId) { (response) in
            switch response {
            case .success(_):
                break
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
        
    }
    
    func putFeedUnlike(postId: Int) {
        FeedAPI.shared.putFeedUnlike(postId: postId) { (response) in
            switch response {
            case .success(_):
                break
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}
