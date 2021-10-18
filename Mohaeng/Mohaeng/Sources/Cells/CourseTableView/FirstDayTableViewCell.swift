//
//  FirstDayTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class FirstDayTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let currentLine = CAShapeLayer()
    private let nextLine = CAShapeLayer()
    
    var appCourse: AppCourse = AppCourse(rawValue: 0)!
    
    enum Size {
        // all
        static let smallRadius: CGFloat = 60
        static let radius: CGFloat = 80
        static let horizontalSpacing: CGFloat = 29
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let cellHeight: CGFloat = 302
        static let verticalSpacingWithBottomCell: CGFloat = 52
        static let strokeSize: CGFloat = 10 // 선 굵기
    
        // 30px 직선
        static let lineLength: CGFloat = 30
        static let startOffset: CGFloat = 5
    }
      
    // MARK: points
    // 1. 30px 직선
    private let pathEndPoint = CGPoint(x: Size.screenWidth / 2, y: -Size.startOffset)
    // 2. 60px 원
    private let centerOf60Circle = CGPoint(x: Size.screenWidth / 2 - Size.smallRadius, y: Size.lineLength)
    
    // 3. 80px 원 호
    private let centerOf80Circle = CGPoint(x: Size.horizontalSpacing + Size.radius, y: Size.lineLength + Size.smallRadius + Size.radius)
    private let startOfLower80Circle = CGPoint(x: Size.horizontalSpacing, y: Size.lineLength + Size.smallRadius + Size.radius - Size.startOffset)
    
    // 방향 바꾸기 테스트용 CGPoints
    private let pathStartPoint = CGPoint(x: Size.horizontalSpacing, y: Size.lineLength + Size.smallRadius + Size.radius + Size.startOffset)
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayLabelBgView: UIView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
        initFirstPath()
        initNextPath()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        dayLabelBgView.makeRounded(radius: dayLabelBgView.frame.height / 2)
    }
    
    private func initFirstPath() {
        // path 생성하기
        let path = UIBezierPath()
        path.move(to: pathStartPoint)
        
        // 3. 80px 원 호 - 위쪽 반
        path.addArc(withCenter: centerOf80Circle, radius: 80, startAngle: CGFloat.pi, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        // 2. 60px 원 호
        path.addArc(withCenter: centerOf60Circle, radius: 60, startAngle: CGFloat.pi / 2, endAngle: 0, clockwise: false)
        
        // 1. 30px 세로 직선
        path.addLine(to: pathEndPoint)
        
        currentLine.fillMode = .forwards
        currentLine.fillColor = UIColor.clear.cgColor
        currentLine.lineWidth = Size.strokeSize
        currentLine.path = path.cgPath
        
        currentLine.lineCap = .round
        
    }
    
    private func initNextPath() {
        // path 생성하기
        let leftPath = RoadMapPath(centerY: 250).getDownwardPath()
        
        nextLine.fillMode = .forwards
        nextLine.fillColor = UIColor.clear.cgColor
        nextLine.lineWidth = Size.strokeSize
        nextLine.path = leftPath.cgPath
        
        nextLine.lineCap = .round
        
    }
    
    func setCell(challenge: TodayChallenge, property: Int) {
        guard let course = AppCourse(rawValue: property) else { return }
        appCourse = course
        
        // 날짜 label
        if challenge.year != "" {
            dayLabelBgView.isHidden = false
            dayLabelBgView.backgroundColor = appCourse.getDarkColor()
            
            dayLabel.text = "\(challenge.month).\(challenge.day) 완료"
        } else {
            dayLabelBgView.isHidden = true
        }
        
        // n일차 label
        dayCountLabel.text = "1일차"
        // 미션 label
        descriptionLabel.text = challenge.title
        
        // situation에 따른 분기처리
        setColorBySituation(situation: challenge.situation)
        
        // property에 따라 속성 아이콘 변경
        setStamp(situation: challenge.situation)
    }
    
    func setOnboardingCell(challengeName: String, property: Int) {
        guard let course = AppCourse(rawValue: property) else { return }
        appCourse = course
        
        dayLabelBgView.isHidden = false
        if let appCourse = AppCourse(rawValue: property) {
            dayLabelBgView.backgroundColor = appCourse.getDarkColor()
        }
        dayLabel.text = "  완료  "
        dayCountLabel.text = "1일차"
        descriptionLabel.text = challengeName
        setColorBySituation(situation: 2)
        setStamp(situation: 2)
    }
    
    // 점선, 실선 처리
    func setDashedLine(line: CAShapeLayer) {
        line.lineDashPattern = [RoadMapPath(centerY: 0).getDashPattern(), RoadMapPath(centerY: 0).getBlankPattern()]
        line.lineDashPhase = 5
    }
    
    func setPlainLine(line: CAShapeLayer) {
        line.lineDashPattern = [1]
    }
    
    // set property functions
    
    func setStamp(situation: Int) {
        // 도장 이미지
        if situation == 2 {
            propertyImageView.image = appCourse.getSmallImage()
        } else {
            propertyImageView.image = appCourse.getUndoneStampImage()
        }
    }
    
    func setNextSituation(next: Int) {
        switch next {
        case 0:
            nextLine.strokeColor = UIColor.Grey4.cgColor
            setDashedLine(line: nextLine)
        case 1:
            nextLine.strokeColor = appCourse.getDarkColor().cgColor
            setDashedLine(line: nextLine)
        case 2:
            nextLine.strokeColor = appCourse.getDarkColor().cgColor
            setPlainLine(line: nextLine)
            
        default:
            break
        }
        self.contentView.layer.insertSublayer(nextLine, at: 0)
    }
    
    private func setColorBySituation(situation: Int) {
        switch situation {
        case 0: // 진행 전 챌린지
            currentLine.strokeColor = UIColor.Grey4.cgColor
            setDashedLine(line: currentLine)
        
        case 1: // 진행 중인 챌린지
            currentLine.strokeColor = appCourse.getDarkColor().cgColor
            setDashedLine(line: currentLine)
            
        case 2: // 완료 된 챌린지
            currentLine.strokeColor = appCourse.getDarkColor().cgColor
            setPlainLine(line: currentLine)
            
        default:
            break
        }
        self.contentView.layer.insertSublayer(currentLine, at: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
