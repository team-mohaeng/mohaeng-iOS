//
//  FeedDetailViewController.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/05.
//

import UIKit

class FeedDetailViewController: UIViewController {

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var feedDetailView: UIView!
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var feedContentsLabel: UILabel!
    @IBOutlet weak var feedNicknameLabel: UILabel!
    @IBOutlet weak var hashTagLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    // MARK: - Properties
    var hashTagList = ["#김승찬", "#정초이", "#담배맛있다", "#여름이었다", "#갓예지ㅋㅋ"]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initAttribute()
        initNavigationBar()
        setHashTagList()
    }

    // MARK: - function
    
    private func initAttribute() {
        feedDetailView.makeRounded(radius: 20)
        feedDetailView.layer.borderColor = UIColor.black.cgColor
        feedDetailView.layer.borderWidth = 1
        
        moodImageView.layer.borderWidth = 1.0
        moodImageView.layer.borderColor = UIColor.black.cgColor
        moodImageView.makeRounded(radius: moodImageView.frame.width / 2)
    }
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        
        navigationItem.title = "소확행 자세히 보기"
    }

    // 해시태그 배열 합치고 3개 이상일 때 줄바꿈
    private func setHashTagList() {
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
}
