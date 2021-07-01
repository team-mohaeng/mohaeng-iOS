//
//  FirstDayTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class FirstDayTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var roadView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var propertyImageView: UIView!
    @IBOutlet weak var propertyBgView: UIView!
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayLabelBgView: UIView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        propertyBgView.makeRounded(radius: propertyBgView.frame.height / 2)
        dayLabelBgView.makeRounded(radius: dayLabelBgView.frame.height / 2)
    }
    
    func setCell(challenge: Challenge) {
        // 날짜 label
        if challenge.date != "" {
            dayLabelBgView.isHidden = false
            
            // date string mm.yy 형식으로 가공
            let start = challenge.date.index(challenge.date.startIndex, offsetBy: 5)
            let range = start..<challenge.date.endIndex
            let shortDate = String(challenge.date[range])
            
            dayLabel.text = "\(shortDate) 완료"
        } else {
            dayLabelBgView.isHidden = true
        }
        
        // n일차 label
        dayCountLabel.text = "\(challenge.day)일차"
        // 미션 label
        descriptionLabel.text = challenge.title
        
        // situation에 따른 분기처리
        setColorBySituation(situation: challenge.situation)
    }
    
    private func setColorBySituation(situation: Int) {
        switch situation {
        case 0: // 진행 전 챌린지
            // 진입 X
            roadView.backgroundColor = UIColor.white
        case 1: // 진행 중인 챌린지
            roadView.backgroundColor = UIColor.Pink
            propertyBgView.backgroundColor = UIColor.CourseUndoneGray
        case 2: // 완료 된 챌린지
            roadView.backgroundColor = UIColor.Pink
            propertyBgView.backgroundColor = UIColor.Pink
        default:
            break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
