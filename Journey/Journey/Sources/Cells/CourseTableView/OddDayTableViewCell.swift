//
//  OddDayTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class OddDayTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let beforeLine = CAShapeLayer()
    let afterLine = CAShapeLayer()
    
    enum Size {
        static let radius: CGFloat = 80
        static let horizontalSpacing: CGFloat = 57
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let cellHeight: CGFloat = 160
        static let circleSize: CGFloat = 66
        static let strokeSize: CGFloat = 10
        // 위 셀과 공유하는 radius 크기
        static let verticalSpacingWithTopCell: CGFloat = 36
        static let verticalSpacingWithBottomCell: CGFloat = 36
    }
    
    private let circle1CenterPoint: CGPoint = CGPoint(x: Size.horizontalSpacing + Size.radius, y: -Size.verticalSpacingWithTopCell)
    private let circle1StartPoint: CGPoint = CGPoint(x: Size.horizontalSpacing, y: -Size.verticalSpacingWithTopCell)
    
    private let circle2StartPoint: CGPoint = CGPoint(x: Size.screenWidth - Size.radius - Size.horizontalSpacing, y: Size.cellHeight - Size.verticalSpacingWithTopCell - Size.radius)
    private let circle2CenterPoint: CGPoint = CGPoint(x: Size.screenWidth - Size.radius - Size.horizontalSpacing, y: Size.cellHeight - Size.verticalSpacingWithBottomCell)

    private let circle3CenterPoint: CGPoint = CGPoint(x: Size.screenWidth - Size.horizontalSpacing - Size.radius, y: Size.cellHeight - Size.verticalSpacingWithBottomCell)
    private let circle3StartPoint: CGPoint = CGPoint(x: Size.screenWidth - Size.horizontalSpacing, y: Size.cellHeight - Size.verticalSpacingWithBottomCell)
    
    var property: Int = 0
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var propertyBgView: UIView!
    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayLabelBgView: UIView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
        initOddPath()
        initNextPath()
        setProperty(by: property)
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        propertyBgView.makeRounded(radius: propertyBgView.frame.height / 2)
        dayLabelBgView.makeRounded(radius: dayLabelBgView.frame.height / 2)
    }
    
    private func initOddPath() {
        let path = UIBezierPath()
        path.move(to: circle1StartPoint)
        
        path.addArc(withCenter: circle1CenterPoint, radius: Size.radius, startAngle: -CGFloat.pi, endAngle: CGFloat.pi / 2, clockwise: false)

        path.addLine(to: circle2StartPoint)

        path.addArc(withCenter: circle2CenterPoint, radius: Size.radius, startAngle: -CGFloat.pi / 2, endAngle: 0, clockwise: true)
        
        beforeLine.fillMode = .forwards
        beforeLine.fillColor = UIColor.clear.cgColor
        beforeLine.lineWidth = 20.0
        beforeLine.path = path.cgPath
        
        self.contentView.layer.insertSublayer(beforeLine, at: 0)
    }
    
    private func initNextPath() {
        let path = UIBezierPath()
        path.move(to: circle3StartPoint)
        path.addArc(withCenter: circle3CenterPoint, radius: Size.radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        
        afterLine.fillMode = .forwards
        afterLine.fillColor = UIColor.clear.cgColor
        afterLine.lineWidth = 20.0
        afterLine.path = path.cgPath
        afterLine.strokeColor = UIColor.Pink2.cgColor
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
        
        // situation에 따른 색상 분기처리
        setColorBySituation(situation: challenge.situation)
        
        // 미션 숨기기
        if challenge.situation == 0 {
            descriptionLabel.text = "쉿, 아직 비밀이야."
        }
    }
    
    func setNextSituation(next: Int) {
        if next == 0 {
            afterLine.strokeColor = UIColor.white.cgColor
            self.contentView.layer.insertSublayer(afterLine, at: 0)
        } else {
            afterLine.strokeColor = UIColor.Pink2.cgColor
            self.contentView.layer.insertSublayer(afterLine, at: 0)
        }
    }
    
    private func setColorBySituation(situation: Int) {
        switch situation {
        case 0: // 진행 전 챌린지
            beforeLine.strokeColor = UIColor.white.cgColor
            propertyBgView.backgroundColor = UIColor.Grey1Bg
        case 1: // 진행 중인 챌린지
            beforeLine.strokeColor = UIColor.Pink2.cgColor
            propertyBgView.backgroundColor = UIColor.Pink2
        case 2: // 완료 된 챌린지
            beforeLine.strokeColor = UIColor.Pink2.cgColor
            propertyBgView.backgroundColor = UIColor.Pink2
        default:
            break
        }
    }

    // set property functions
    
    func setProperty(by property: Int) {
        switch property {
        case Property.health.rawValue:
            setProperty0()
        case Property.memory.rawValue:
            setProperty1()
        case Property.observation.rawValue:
            setProperty2()
        case Property.challenge.rawValue:
            setProperty3()
        default:
            return
        }
    }
    
    // 0: 건강 1: 기억 2: 관찰 3: 도전
    func setProperty0() {
        propertyImageView.image = Const.Image.typeHwithColor
    }
    
    func setProperty1() {
        propertyImageView.image = Const.Image.typeMwithColor
    }
    
    func setProperty2() {
        propertyImageView.image = Const.Image.typeSwithColor
    }
    
    func setProperty3() {
        propertyImageView.image = Const.Image.typeCwithColor
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
