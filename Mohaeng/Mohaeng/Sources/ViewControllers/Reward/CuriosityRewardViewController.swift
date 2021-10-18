//
//  CuriosityRewardViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/19.
//

import UIKit

class CuriosityRewardViewController: RewardBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setUp() {
        type = .curiosity
    }
    
    override func touchButton() {
        navigationController?.pushViewController(WritingRewardViewController(), animated: true)
    }
    
    override func touchSubButton() {
        dismiss(animated: true, completion: nil)
    }

}
