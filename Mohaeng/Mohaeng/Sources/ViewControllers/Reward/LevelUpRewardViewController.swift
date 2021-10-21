//
//  LevelUpRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit

class LevelUpRewardViewController: RewardBaseViewController {
    
    public var levelUp: LevelUp?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUp() {
        if let level = levelUp?.level,
           let imgURL = levelUp?.styleImg {
            self.level = level
            self.imgURL = imgURL
        }
        
        type = .levelUp
    }
    
    /// 이전 VC가 WritingRewardViewController인 경우만 dismiss
    override func touchButton() {
        if navigationController?.previousViewController is WritingRewardViewController {
            self.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.pushViewController(CuriosityRewardViewController(), animated: true)
        }
    }

}
