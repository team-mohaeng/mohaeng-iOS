//
//  LevelUpRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit

/// RewardBaseViewController를 상속받아 사용하므로 Level 값을 꼭 넣어주세요
class LevelUpRewardViewController: RewardBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUp() {
        type = .levelUp
    }
    
    override func touchButton() {
        if navigationController?.previousViewController is WritingRewardViewController {
            self.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.pushViewController(CuriosityRewardViewController(), animated: true)
        }
    }

}
