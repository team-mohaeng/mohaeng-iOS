//
//  CourseFooterView.swift
//  Journey
//
//  Created by 초이 on 2021/08/25.
//

import UIKit

class CourseFooterView: UITableViewHeaderFooterView {
    
    weak var onboardingCourseProtocol: OnboardingCourseProtocol?
    
    private let line = CAShapeLayer()

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var islandImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func awakeFromNib() {
    }
    
    func initLastPath(isDone: Bool) {
        let leftPath = RoadMapPath(centerY: 0).getVeryLastPath()
        
        line.fillMode = .forwards
        line.fillColor = UIColor.clear.cgColor
        line.lineWidth = 10.0
        line.path = leftPath.cgPath
        line.lineCap = .round
        
        if isDone {
            line.lineDashPattern = [1]
            line.strokeColor = UIColor.sampleGreen.cgColor
        } else {
            line.lineDashPhase = 5
            line.lineDashPattern = [RoadMapPath(centerY: 0).getDashPattern(), RoadMapPath(centerY: 0).getBlankPattern()]
            line.strokeColor = UIColor.Grey4.cgColor
        }
        
        self.bgView.layer.insertSublayer(line, at: 2)
    }
    
    func setIslandImage(isDone: Bool) {
        if isDone {
            islandImageView.image = Const.Image.doneIsland
        } else {
            islandImageView.image = Const.Image.undoneIsland
        }
    }
    
    func setNextButton(isOnboarding: Bool) {
        if isOnboarding {
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
        nextButton.makeRounded(radius: nextButton.frame.height / 2)
    }

    @IBAction func touchNextButton(_ sender: UIButton) {
        self.onboardingCourseProtocol?.touchNextButton(sender)
    }
}
