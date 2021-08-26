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
    
    var property: Int = 0
    
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
        setProperty(by: property)
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
        switch next {
        case 0:
            nextLine.strokeColor = UIColor.roadUndoneGrey.cgColor
            setDashedLine(line: nextLine)
        case 1:
            nextLine.strokeColor = UIColor.sampleGreen.cgColor
            setDashedLine(line: nextLine)
        case 2:
            nextLine.strokeColor = UIColor.sampleGreen.cgColor
            setPlainLine(line: nextLine)
            
        default:
            break
        }
        self.contentView.layer.insertSublayer(nextLine, at: 0)
    }
    
    private func setColorBySituation(situation: Int) {
        switch situation {
        case 0: // 진행 전 챌린지
            currentLine.strokeColor = UIColor.roadUndoneGrey.cgColor
            setDashedLine(line: currentLine)
        
        case 1: // 진행 중인 챌린지
            currentLine.strokeColor = UIColor.sampleGreen.cgColor
            setDashedLine(line: currentLine)
            
        case 2: // 완료 된 챌린지
            currentLine.strokeColor = UIColor.sampleGreen.cgColor
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
        propertyImageView.image = Const.Image.typeHchallengeC
    }
    
    func setProperty1() {
        propertyImageView.image = Const.Image.typeMchallengeC
    }
    
    func setProperty2() {
        propertyImageView.image = Const.Image.typeSchallengeC
    }
    
    func setProperty3() {
        propertyImageView.image = Const.Image.typeCchallengeC
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
