//
//  ChallengeRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit

class ChallengeRewardViewController: RewardBaseViewController {

    public var completedChallengeData: CompletedChallengeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUp() {
        guard let data = completedChallengeData else { return }
        happy = data.challengeCompletion.happy
        type = .challenge
    }
    
    /// 우선 순위 1) 코스 완주 2) 레벨업 3) 글쓰기 유도뷰
    override func touchButton() {
        guard let data = completedChallengeData else { return }
        
        let levelUp = data.levelUp
        let courseCompletion = data.courseCompletion

        if courseCompletion.fullHappy != nil,
           courseCompletion.happy != nil,
           courseCompletion.userHappy != nil {
            
            let viewController = CourseRewardViewController()
            viewController.completedChallengeData = data
            navigationController?.pushViewController(viewController, animated: true)
            return
        }
        
        if levelUp.level != nil,
           levelUp.styleImg != nil {
            let viewController = LevelUpRewardViewController()
            viewController.levelUp = levelUp
            navigationController?.pushViewController(viewController, animated: true)
            return
        }
        
        navigationController?.pushViewController(CuriosityRewardViewController(), animated: true)
        
    }
}
