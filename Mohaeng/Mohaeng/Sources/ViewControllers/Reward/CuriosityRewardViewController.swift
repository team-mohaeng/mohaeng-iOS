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
        let moodStoryboard = UIStoryboard(name: Const.Storyboard.Name.mood, bundle: nil)
        guard let moodViewController = moodStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.mood) as? MoodViewController else { return }
        
        navigationController?.pushViewController(moodViewController, animated: true)
    }
    
    override func touchSubButton() {
        dismiss(animated: true, completion: nil)
    }

}
