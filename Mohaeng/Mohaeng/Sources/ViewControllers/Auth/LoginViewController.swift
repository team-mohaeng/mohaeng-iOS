//
//  LoginViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet var kakaoLoginButton: UIButton!
    @IBOutlet var appleLoginButton: UIButton!
    @IBOutlet var emailLoginButton: UIButton!
    @IBOutlet weak var mohaengLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setLabelFont()
        setButtonUI()
    }
    
    // MARK: - Functions
    
    private func setLabelFont() {
        mohaengLabel.font = .gmarketFont(weight: GmarketFontSize.medium, size: 24)
    }
    
    private func initNavigationBar() {
        self.navigationController?.initTransparentNavBar()
    }
    
    private func setButtonUI() {
        [kakaoLoginButton, appleLoginButton, emailLoginButton].forEach {
            $0?.makeRounded(radius: 6)
        }
        emailLoginButton.makeRoundedWithBorder(radius: 6, color: UIColor.Grey5.cgColor, borderWith: 1)
    }
    
    private func pushSignUpFirstViewController() {
        let signupFirstStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpFirst, bundle: nil)
        guard let signUpFirstViewController  = signupFirstStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpFirst) as? SignUpFirstViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpFirstViewController, animated: true)
    }
    
    private func pushEmailLoginViewController() {
        let emailLoginStoryboard = UIStoryboard(name: Const.Storyboard.Name.emailLogin, bundle: nil)
        guard let emailLoginViewController = emailLoginStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.emailLogin) as?
                EmailLoginViewController else { return }
        self.navigationController?.pushViewController(emailLoginViewController, animated: true)
    }
    
    // MARK: - @IBAction
    @IBAction func touchSignEmailButton(_ sender: UIButton) {
        pushSignUpFirstViewController()
    }
    
    @IBAction func touchEmailLoginButton(_ sender: UIButton) {
        pushEmailLoginViewController()
    }
    
    @IBAction func touchAppleLoginButton(_ sender: Any) {
        presentHomeViewController()
    }
    
    // 편의용 (나중에 지워야 함)
    func presentHomeViewController() {
        let tabbarStoryboard = UIStoryboard(name: Const.Storyboard.Name.tabbar, bundle: nil)
        guard let tabbarViewController = tabbarStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.tabbar) as? TabbarViewController else {
            return
        }
        tabbarViewController.modalPresentationStyle = .fullScreen
        tabbarViewController.modalTransitionStyle = .crossDissolve
        self.present(tabbarViewController, animated: true, completion: nil)
    }
}
