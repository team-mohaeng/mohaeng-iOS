//
//  CourseRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit

class CourseRewardViewController: RewardBaseViewController {
    
    public var completedChallengeData: CompletedChallengeData?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUp() {
        guard let data = completedChallengeData else { return }
        happy = data.challengeCompletion.happy
        courseCompletion = data.courseCompletion
        type = .course
    }
    
    /// 우선 순위 1) 레벨업 2) 글쓰기 유도뷰
    override func touchButton() {
        guard let data = completedChallengeData else { return }
        let levelUp = data.levelUp
        
        if levelUp.level != nil,
           levelUp.styleImg != nil {
            let viewController = LevelUpRewardViewController()
            viewController.levelUp = levelUp
            viewController.isPanalty = data.challengeCompletion.isPenalty
            navigationController?.pushViewController(viewController, animated: true)
            return
        }
        
        if !data.challengeCompletion.isPenalty {
            navigationController?.pushViewController(WritingRewardViewController(), animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

}
