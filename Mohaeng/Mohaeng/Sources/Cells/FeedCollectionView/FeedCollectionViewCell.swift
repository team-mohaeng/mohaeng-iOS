//
//  FeedCollectionViewCell.swift
//  Journey
//
//  Created by 윤예지 on 2021/09/03.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var courseDayLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var todayFeedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initViewRounding()
    }
    
    private func initViewRounding() {
        previewImageView.makeRounded(radius: 4)
        todayFeedView.makeRounded(radius: 4)
    }
    
    func configureTodayCellUI() {
        backgroundColor = .todayYellow
        todayFeedView.isHidden = false
    }
    
    func configureDefaultUI() {
        backgroundColor = .white
        todayFeedView.isHidden = true
    }
    
    func setData(data: Feed) {
        courseDayLabel.text = "\(data.course) \(data.challenge)일차"
        contentsLabel.text = data.content
        nicknameLabel.text = data.nickname
        dateLabel.text = data.month + "월 " + data.day + "일"
        previewImageView.updateServerImage(data.image)
    }
    
}
