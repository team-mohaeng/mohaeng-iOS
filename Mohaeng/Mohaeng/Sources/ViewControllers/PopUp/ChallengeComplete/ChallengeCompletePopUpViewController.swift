//
//  ChallengeCompletePopUpViewController.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/10.
//

import UIKit

class ChallengeCompletePopUpViewController: UIViewController {
    
    // MARK: - Properties
    
    enum PopUpUsage: Int {
        case challenge = 0, onboarding
    }
    
    var popUpUsage: PopUpUsage = .challenge
    weak var challengePopUpProtocol: ChallengePopUpProtocol?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var popUpBgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var perfectButton: UIButton!
    @IBOutlet weak var shameButton: UIButton!
    @IBOutlet weak var barelyButton: UIButton!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewRounding()
        setFont()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        popUpBgView.makeRounded(radius: 30)
        perfectButton.makeRounded(radius: 14)
        shameButton.makeRounded(radius: 14)
        barelyButton.makeRounded(radius: 14)
    }
    
    private func setFont() {
        titleLabel.font = UIFont.gmarketFont(weight: .light, size: 20)
    }
    
    private func touchCompleteButton() {
        switch popUpUsage {
        case .challenge:
            self.dismiss(animated: true) {
                self.challengePopUpProtocol?.pushToFinishViewController()
            }
        case .onboarding:
            self.dismiss(animated: true) {
                self.challengePopUpProtocol?.pushToNextOnboardingViewController()
            }
        }
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchCloseButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func touchPerfectButton(_ sender: UIButton) {
        touchCompleteButton()
    }
    
    @IBAction func touchShameButton(_ sender: Any) {
        touchCompleteButton()
    }
    
    @IBAction func touchBarelyButton(_ sender: Any) {
        touchCompleteButton()
    }
}
