//
//  ChallengeHelpPopUpViewController.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/12.
//

import UIKit

class ChallengeHelpPopUpViewController: UIViewController {
    
    // MARK: - Properties
    
    var challengePopUpProtocol: ChallengePopUpProtocol?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var popUpBgView: UIView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        popUpBgView.makeRounded(radius: 30)
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
