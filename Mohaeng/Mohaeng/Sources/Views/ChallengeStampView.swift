//
//  ChallengeStampView.swift
//  Journey
//
//  Created by 초이 on 2021/08/20.
//

import UIKit
import Kingfisher

class ChallengeStampView: UIView {

    // MARK: - Properties
    weak var challengePopUpProtocol: ChallengePopUpProtocol?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var characterLineView: UIView!
    @IBOutlet weak var characterLineLabel: UILabel!
    @IBOutlet weak var dayLabelView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var challengeNameLabel: UILabel!
    @IBOutlet weak var stampBgView: UIView!
    @IBOutlet weak var stampImageView: UIImageView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var availableHappyLabel: UILabel!
    @IBOutlet weak var availableBadgeLabel: UILabel!
    @IBOutlet weak var completeEffectImageView: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        initViewRounding()
        addTapGesture()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        characterLineView.makeRounded(radius: 20)
        dayLabelView.makeRounded(radius: dayLabelView.frame.height / 2)
        stampBgView.makeRounded(radius: 20)
        
    }
    
    private func addTapGesture() {
        let stampGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchStamp(_:)))
        stampImageView.addGestureRecognizer(stampGesture)
    }
    
    func setData(data: TodayChallengeData) {
        
        // main character image
        let url = URL(string: data.mainCharacterImg)!
        let resource = ImageResource(downloadURL: url)

        characterImageView.kf.setImage(with: resource)
        
        // find today challenge
        let challenge: TodayChallenge = findTodayChallenge(course: data.course)
        
        // by situation
        if challenge.situation != 2 {
            // 대사
            characterLineLabel.text = challenge.beforeMent
            // 스탬프
            if let appCourse = AppCourse(rawValue: data.course.property) {
                stampImageView.image = appCourse.getUndoneStampImage()
            }
            stampImageView.isUserInteractionEnabled = true
            completeEffectImageView.isHidden = true
        } else {
            // 완료한 챌린지
            // 대사
            characterLineLabel.text = challenge.afterMent
            // 스탬프
            if let appCourse = AppCourse(rawValue: data.course.property) {
                stampImageView.image = appCourse.getDoneStampImage()
            }
            stampImageView.isUserInteractionEnabled = false
            completeEffectImageView.isHidden = false
        }
        
        // 챌린지 정보
        dayLabel.text = "\(challenge.day)일차"
        challengeNameLabel.text = challenge.title
        if let appCourse = AppCourse(rawValue: data.course.property) {
            dayLabelView.backgroundColor = appCourse.getDarkColor()
            challengeNameLabel.textColor = appCourse.getDarkColor()
        }
        availableHappyLabel.text = "해피지수가 \(challenge.happy)%"
        
        if !challenge.badges.isEmpty {
            availableBadgeLabel.text = "\(challenge.badges.joined(separator: ", "))"
        }
    }
    
    func findTodayChallenge(course: TodayChallengeCourse) -> TodayChallenge {
        for (index, item) in course.challenges.enumerated() {
            if item.situation == 1 {
                return item
            } else if item.situation == 0 {
                return course.challenges[index-1]
            }
        }
        // 모든 챌린지가 완료되었을 때
        return course.challenges.last!
    }
    
    // MARK: - @IBAction Functions

    @objc func touchStamp(_ gesture: UITapGestureRecognizer) {
        self.challengePopUpProtocol?.touchStampButton(gesture)
    }
    
    @IBAction func touchHelp(_ sender: UIButton) {
        self.challengePopUpProtocol?.touchHelpButton(sender)
    }
}
