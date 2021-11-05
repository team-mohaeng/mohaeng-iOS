//
//  WritingRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit

class WritingRewardViewController: RewardBaseViewController {

// MARK: - Properties
    public var writingResponse: WritingResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideBar()
    }

    override func setUp() {
        guard let writingResponse = writingResponse else { return }
        happy = writingResponse.happy
        type = .writing
    }
    
    override func touchButton() {
        guard let levelUp = writingResponse?.levelUp else { return }
        
        if  levelUp.level != nil {
            let levelUpRewardViewController = LevelUpRewardViewController()
            levelUpRewardViewController.levelUp = levelUp
            levelUpRewardViewController.isPanalty = false
            
            navigationController?.pushViewController(levelUpRewardViewController, animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func hideBar() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }

}
