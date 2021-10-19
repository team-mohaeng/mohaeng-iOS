//
//  ChallengeRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit

class ChallengeRewardViewController: RewardBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUp() {
        happy = 15
        type = .challenge
    }
    
    // TODO : - 플로우에 따라 분기처리
    override func touchButton() {
        navigationController?.pushViewController(CourseRewardViewController(), animated: true)
    }
}
