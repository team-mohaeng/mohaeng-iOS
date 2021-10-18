//
//  CourseRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit


/// RewardBaseViewController를 상속받아 사용하므로 happy 값을 꼭 넣어주세요
class CourseRewardViewController: RewardBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUp() {
        happy = 15
        type = .course
    }
    
    // TODO : - 플로우에 따라 분기처리
    override func touchButton() {
        navigationController?.pushViewController(LevelUpRewardViewController(), animated: true)
    }

}
