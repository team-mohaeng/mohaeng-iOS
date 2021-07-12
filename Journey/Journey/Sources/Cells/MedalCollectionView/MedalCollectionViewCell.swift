//
//  MedalCollectionViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import UIKit

class MedalCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var propertyImageView: UIImageView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        cellBgView.makeRounded(radius: 10)
        completeView.makeRounded(radius: completeView.frame.height / 2)
    }
    
    func setCell(course: Course) {
        // TODO: - property 이미지 바꿔주기
        dayLabel.text = "\(course.totalDays)일 코스"
        titleLabel.text = course.title
        
        if let lastChallenge = course.challenges.last {
            dateLabel.text = "\(lastChallenge.year).\(lastChallenge.month).\(lastChallenge.day)"
        }
    }

}
