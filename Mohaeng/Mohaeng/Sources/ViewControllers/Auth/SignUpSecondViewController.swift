//
//  SignUpSecondViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class SignUpSecondViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet var firstCheckButton: UIButton!
    @IBOutlet var secondCheckButton: UIButton!
    @IBOutlet var thirdCheckButton: UIButton!
    @IBOutlet var agreeButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonRounded()
    }
    // MARK: - Functions
    
    private func makeButtonRounded() {
        agreeButton.makeRounded(radius: 20)
    }
    
    private func setAgreeButton(color: UIColor, bool: Bool) {
        agreeButton.backgroundColor = color
        agreeButton.isEnabled = bool
    }
    
    private func pushSignUpThirdViewController() {
        let signUpThirdStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpThird, bundle: nil)
        
        guard let signUpThirdViewController = signUpThirdStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpThird) as?
                SignUpThirdViewController else {
                    return
                }
        self.navigationController?.pushViewController(signUpThirdViewController, animated: true)
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchCheckButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        
        let first = firstCheckButton.isSelected
        let second = secondCheckButton.isSelected
        let third = thirdCheckButton.isSelected
        
        if first && second && third {
            setAgreeButton(color: .DeepYellow, bool: true)
        } else {
            setAgreeButton(color: .LoginYellow, bool: false)
        }
    }
    @IBAction func touchAgreeButton(_ sender: UIButton) {
        pushSignUpThirdViewController()
    }
}
