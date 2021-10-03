//
//  LoginViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var kakaoLoginButton: UIButton!
    @IBOutlet var appleLoginButton: UIButton!
    @IBOutlet var emailLoginButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonUI()
    }
    
    // MARK: - Functions
    private func setButtonUI() {
        [kakaoLoginButton, appleLoginButton, emailLoginButton].forEach {
            $0?.makeRounded(radius: 6)
        }
        emailLoginButton.layer.borderColor = UIColor.Grey5.cgColor
        emailLoginButton.layer.borderWidth = 1
    }
    
    //MARK: - @IBAction
    @IBAction func touchSignEmailButton(_ sender: UIButton) {
        let signupFirstStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpFirst, bundle: nil)
        guard let signUpFirstViewController  = signupFirstStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpFirst) as? SignUpFirstViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpFirstViewController, animated: true)
    }
    
    @IBAction func touchEmailLoginButton(_ sender: UIButton) {
        let emailLoginStoryboard = UIStoryboard(name: Const.Storyboard.Name.emailLogin, bundle: nil)
        guard let emailLoginViewController = emailLoginStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.emailLogin) as?
                EmailLoginViewController else { return }
        self.navigationController?.pushViewController(emailLoginViewController, animated: true)
    }
}
