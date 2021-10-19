//
//  LevelUpRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit

class LevelUpRewardViewController: RewardBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUp() {
        level = 15
        type = .levelUp

    }
    
    // TODO : - 플로우에 따라 분기처리
    override func touchButton() {
        navigationController?.pushViewController(CuriosityRewardViewController(), animated: true)
    }

}
