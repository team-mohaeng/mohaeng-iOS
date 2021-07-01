//
//  OddDayTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class OddDayTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let startPoint: CGPoint = CGPoint(x: 47 + 75, y: -10)
    let endPoint: CGPoint = CGPoint(x: UIScreen.main.bounds.width - 47 - 75, y: 188 - 75 - 48)
    let endPoint2: CGPoint = CGPoint(x: UIScreen.main.bounds.width - 47 - 75, y: 188 - 48)
    let line = CAShapeLayer()
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var propertyBgView: UIView!
    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var nextDayRoadView: UIView!
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayLabelBgView: UIView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
        initOddPath()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        propertyBgView.makeRounded(radius: propertyBgView.frame.height / 2)
        dayLabelBgView.makeRounded(radius: dayLabelBgView.frame.height / 2)
    }
    
    private func initOddPath() {
        let path = UIBezierPath()
        path.move(to: startPoint)
        
        path.addArc(withCenter: startPoint, radius: 75, startAngle: -CGFloat.pi, endAngle: CGFloat.pi / 2, clockwise: false)
        
        path.addLine(to: endPoint)
        
        path.addArc(withCenter: endPoint2, radius: 75, startAngle: -CGFloat.pi / 2, endAngle: 0, clockwise: true)
        
        line.fillMode = .forwards
        line.fillColor = UIColor.clear.cgColor
        line.lineWidth = 20.0
        line.path = path.cgPath
        
        self.contentView.layer.insertSublayer(line, at: 0)
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
        
        // situation에 따른 색상 분기처리
        setColorBySituation(situation: challenge.situation)
        
        // 미션 숨기기
        if challenge.situation == 0 {
            descriptionLabel.text = "쉿, 아직 비밀이야."
        }
    }
    
    private func setColorBySituation(situation: Int) {
        switch situation {
        case 0: // 진행 전 챌린지
            line.strokeColor = UIColor.white.cgColor
            propertyBgView.backgroundColor = UIColor.CourseUndoneGray
        case 1: // 진행 중인 챌린지
            line.strokeColor = UIColor.Pink.cgColor
            propertyBgView.backgroundColor = UIColor.CourseUndoneGray
        case 2: // 완료 된 챌린지
            line.strokeColor = UIColor.Pink.cgColor
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
