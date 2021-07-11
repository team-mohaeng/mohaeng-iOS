//
//  FirstDayTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class FirstDayTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let line = CAShapeLayer()
    
    enum Size {
        static let radius: CGFloat = 80
        static let horizontalSpacing: CGFloat = 57
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let cellHeight: CGFloat = 120
        static let verticalSpacingWithBottomCell: CGFloat = 33
    }
    
    private let centerPoint: CGPoint = CGPoint(x: Size.screenWidth - Size.horizontalSpacing - Size.radius, y: Size.cellHeight - Size.verticalSpacingWithBottomCell)
    private let startPoint: CGPoint = CGPoint(x: Size.screenWidth - Size.horizontalSpacing, y: Size.cellHeight - Size.verticalSpacingWithBottomCell)
    
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
        initFirstPath()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        propertyBgView.makeRounded(radius: propertyBgView.frame.height / 2)
        dayLabelBgView.makeRounded(radius: dayLabelBgView.frame.height / 2)
    }
    
    private func initFirstPath() {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addArc(withCenter: centerPoint, radius: Size.radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        
        line.fillMode = .forwards
        line.fillColor = UIColor.clear.cgColor
        line.lineWidth = 20.0
        line.path = path.cgPath
        
        self.contentView.layer.insertSublayer(line, at: 0)
        
    }
    
    func setCell(challenge: Challenge) {
        // 날짜 label
        if challenge.year != "" {
            dayLabelBgView.isHidden = false
            
            dayLabel.text = "\(challenge.month).\(challenge.day) 완료"
        } else {
            dayLabelBgView.isHidden = true
        }
        
        // n일차 label
        dayCountLabel.text = "\(challenge.id)일차"
        // 미션 label
        descriptionLabel.text = challenge.title
        
        // situation에 따른 분기처리
        setColorBySituation(situation: challenge.situation)
    }
    
    func setNextSituation(next: Int) {
        if next == 0 {
            line.strokeColor = UIColor.white.cgColor
        } else if next == 2 {
            line.strokeColor = UIColor.Pink2.cgColor
        }
    }
    
    private func setColorBySituation(situation: Int) {
        switch situation {
        case 0: // 진행 전 챌린지
            // 진입 X
            roadView.backgroundColor = UIColor.white
        case 1: // 진행 중인 챌린지
            roadView.backgroundColor = UIColor.Pink2
            propertyBgView.backgroundColor = UIColor.Pink2
        case 2: // 완료 된 챌린지
            roadView.backgroundColor = UIColor.Pink2
            propertyBgView.backgroundColor = UIColor.Pink2
        default:
            break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
