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
    
    @IBOutlet weak var feedDetailView: UIView!
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var feedContentsLabel: UILabel!
    @IBOutlet weak var feedNicknameLabel: UILabel!
    @IBOutlet weak var hashTagLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dayLabel: UILabel!
    
    // MARK: - Properties
    var feedInfo: Community = Community(postID: 0, nickname: "", mood: 0, mainImage: "", likeCount: 0, content: "", hasLike: false, hashtags: [""], year: "", month: "", day: "", week: "")
    var likeCount: Int = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setData()
        getFeedDetail(postId: feedInfo.postID)
        initNavigationBar()
        initAttribute()
    }
    
    // MARK: - function
    
    private func initAttribute() {
        feedDetailView.makeRounded(radius: 20)
    }
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        let item = UIBarButtonItem(image: UIImage(named: "gnbIconTrash"), style: .plain, target: self, action: #selector(touchRemoveButton))
        item.tintColor = .black
//        self.navigationItem.rightBarButtonItem = item
    }
    
    private func setData() {
        mainImageView.kf.setImage(with: URL(string: feedInfo.mainImage))
        feedContentsLabel.text = feedInfo.content
        feedNicknameLabel.text = feedInfo.nickname
        likeCountLabel.text = String(feedInfo.likeCount)
        setMoodImage(status: feedInfo.mood)
        setHashTagList(hashTagList: feedInfo.hashtags)
        dayLabel.text = "\(feedInfo.year).\(feedInfo.month).\(feedInfo.day) (\(feedInfo.week))"
    }
    
    private func setMoodImage(status: Int) {
        // 0: 그저 그런 하루, 1: 나름 괜찮은 하루, 2: 인류애 넘치는 하루
        switch status {
        case 0:
            moodImageView.image = Const.Image.imgFaceGraphic1
        case 1:
            moodImageView.image = Const.Image.imgFaceGraphic2
        case 2:
            moodImageView.image = Const.Image.imgFaceGraphic3
        default:
            break
        }
    }
    
    // 해시태그 배열 합치고 3개 이상일 때 줄바꿈
    private func setHashTagList(hashTagList: [String]) {
        var joinedHashTag: String = ""
        if hashTagList.count > 3 {
            joinedHashTag = hashTagList[0..<3].joined(separator: " ")
            joinedHashTag.append("\n")
            joinedHashTag.append(hashTagList[3..<5].joined(separator: " "))
            hashTagLabel.text = joinedHashTag
        } else {
            hashTagLabel.text = hashTagList.joined(separator: " ")
        }
    }
    
    private func plusLikeCount() {
        guard let like = likeCountLabel.text else { return }
        guard let likeCount = Int(like) else { return }
        likeCountLabel.text = "\(likeCount + 1)"
    }
    
    private func minusLikeCount() {
        guard let like = likeCountLabel.text else { return }
        guard let likeCount = Int(like) else { return }
        likeCountLabel.text = "\(likeCount - 1)"
    }
    
    private func setLikeButtonBackgroundImage(buttonStatus: Bool) {
        switch buttonStatus {
        case true:
            likeButton.isSelected = true
            likeButton.setImage(Const.Image.heartFullImg, for: .normal)
            likeCountLabel.textColor = .Pink2
            likeCountLabel.font = UIFont.spoqaHanSansNeo(weight: .bold, size: 10)
        case false:
            likeButton.isSelected = false
            likeButton.setImage(Const.Image.heartImg, for: .normal)
            likeCountLabel.textColor = .white
        }
    }
    
    private func updateData(data: Community) {
        likeCountLabel.text = String(data.likeCount)
        if data.hasLike {
            likeButton.isSelected = true
        }
        setLikeButtonBackgroundImage(buttonStatus: likeButton.isSelected)
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchLikeButton(_ sender: Any) {
        likeButton.isSelected = !likeButton.isSelected
        if likeButton.isSelected {
            putFeedLike(postId: feedInfo.postID)
            setLikeButtonBackgroundImage(buttonStatus: likeButton.isSelected)
            plusLikeCount()
        } else {
            putFeedUnlike(postId: feedInfo.postID)
            setLikeButtonBackgroundImage(buttonStatus: likeButton.isSelected)
            minusLikeCount()
        }
    }
    
    @objc func touchRemoveButton() {
        var removePopUp = PopUpViewController(nibName: Const.Xib.Name.popUp, bundle: nil)
        removePopUp.modalPresentationStyle = .overCurrentContext
        removePopUp.modalTransitionStyle = .crossDissolve
        removePopUp.popUpUsage = .noImage
        removePopUp.popUpActionDelegate = self
        tabBarController?.present(removePopUp, animated: true, completion: nil)
        
        removePopUp.titleLabel.text = "당신, 정말 삭제할거야?"
        removePopUp.descriptionLabel.text = "지금 삭제하면 다시 볼 수 없어. \n그래도 소확행을 삭제하겠어?"
        removePopUp.pinkButton?.setTitle("아니!", for: .normal)
        removePopUp.whiteButton?.setTitle("삭제할래", for: .normal)
        removePopUp.popUpImageView.isHidden = true
    }
}

extension FeedDetailViewController: PopUpActionDelegate {
    func touchPinkButton(button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func touchWhiteButton(button: UIButton) {
        deleteFeed(postId: feedInfo.postID)
        
        let feedStoryboard = UIStoryboard(name: Const.Storyboard.Name.feed, bundle: nil)
        guard let feedViewController = feedStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.feed) as? FeedViewController else { return }
        
        self.navigationController?.pushViewController(feedViewController, animated: true)
    }
}

extension FeedDetailViewController {
    
    func getFeedDetail(postId: Int) {
        FeedAPI.shared.getFeedDetail(postId: postId) { (response) in
            switch response {
            case .success(let feeds):
                if let data = feeds as? Community {
                    self.updateData(data: data)
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
    
    func deleteFeed(postId: Int) {
//        FeedAPI.shared.deleteFeed(postId: postId) { (response) in
//            switch response {
//            case  .success(_):
//                break
//            case .requestErr(let message):
//                print("requestErr", message)
//            case .pathErr:
//                print(".pathErr")
//            case .serverErr:
//                print("serverErr")
//            case .networkFail:
//                print("networkFail")
//            }
//        }
    }
}
