//
//  EvenDayTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class EvenDayTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let currentLine = CAShapeLayer()
    let nextLine = CAShapeLayer()
    
    var appCourse: AppCourse = AppCourse(rawValue: 1)!
    
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
        initEvenPath()
        initNextPath()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        dayLabelBgView.makeRounded(radius: dayLabelBgView.frame.height / 2)
    }
    
    private func initEvenPath() {
        
        let leftPath = RoadMapPath(centerY: 0).getDownwardPath()
        
        currentLine.fillMode = .forwards
        currentLine.fillColor = UIColor.clear.cgColor
        currentLine.lineWidth = 10.0
        currentLine.path = leftPath.cgPath
        currentLine.lineCap = .round
        currentLine.lineDashPhase = 5
        currentLine.lineDashPattern = [RoadMapPath(centerY: 0).getDashPattern(), RoadMapPath(centerY: 0).getBlankPattern()]
        
        self.contentView.layer.insertSublayer(currentLine, at: 2)
    }
    
    private func initNextPath() {
        let leftPath = RoadMapPath(centerY: 160).getUpwardPath()
        
        nextLine.fillMode = .forwards
        nextLine.fillColor = UIColor.clear.cgColor
        nextLine.lineWidth = 10.0
        nextLine.path = leftPath.cgPath
        nextLine.lineCap = .round
        nextLine.lineDashPhase = 5
        nextLine.lineDashPattern = [RoadMapPath(centerY: 0).getDashPattern(), RoadMapPath(centerY: 0).getBlankPattern()]
        
        self.contentView.layer.insertSublayer(nextLine, at: 0)
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
        dayCountLabel.text = "\(challenge.day)일차"
        // 미션 label
        descriptionLabel.text = challenge.title
        
        // situation에 따른 색상 분기처리
        setColorBySituation(situation: challenge.situation)
        
        // property에 따라 속성 아이콘 변경
        setStamp(situation: challenge.situation)
        
        // 미션 숨기기
        if challenge.situation == 0 {
            descriptionLabel.text = "쉿, 아직 비밀이야."
        }
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
            
            dayCountLabel.textColor = UIColor.Grey2
            descriptionLabel.textColor = UIColor.Grey2
        
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
    
    // 점선, 실선 처리
    func setDashedLine(line: CAShapeLayer) {
        line.lineDashPattern = [RoadMapPath(centerY: 0).getDashPattern(), RoadMapPath(centerY: 0).getBlankPattern()]
        line.lineDashPhase = 5
    }
    
    func setPlainLine(line: CAShapeLayer) {
        line.lineDashPattern = [1]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
