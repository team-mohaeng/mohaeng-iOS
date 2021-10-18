//
//  WritingRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit


/// RewardBaseViewController를 상속받아 사용하므로 happy 값을 꼭 넣어주세요
class WritingRewardViewController: RewardBaseViewController {

// MARK: - Properties
    public var writingResponse: WritingResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUp() {
        guard let writingResponse = writingResponse else { return }
        happy = writingResponse.happy
        type = .writing
    }
    
    override func touchButton() {
        guard let writingResponse = writingResponse else { return }
        if let level = writingResponse.levelUp.level {
            let levelUpRewardViewController = LevelUpRewardViewController()
            levelUpRewardViewController.level = level
            navigationController?.pushViewController(levelUpRewardViewController, animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
