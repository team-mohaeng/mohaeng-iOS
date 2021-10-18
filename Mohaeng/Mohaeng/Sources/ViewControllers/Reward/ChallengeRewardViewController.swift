//
//  ChallengeRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit

/// RewardBaseViewController를 상속받아 사용하므로 happy 값을 꼭 넣어주세요
class ChallengeRewardViewController: RewardBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUp() {
        happy = 15
        type = .challenge
    }
    
    // TODO : 우선순위 1) 코스 완주 2) 레벨업 3) 글쓰기 유도
    override func touchButton() {
        navigationController?.pushViewController(CourseRewardViewController(), animated: true)
    }
}
