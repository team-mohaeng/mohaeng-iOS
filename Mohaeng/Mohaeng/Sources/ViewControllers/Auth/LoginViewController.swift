//
//  LoginViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import UIKit
import Moya
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var signUpUser = SignUpUser.shared
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var backgroundTopSpace: NSLayoutConstraint!
    @IBOutlet var kakaoLoginButton: UIButton!
    @IBOutlet var appleLoginButton: UIButton!
    @IBOutlet var emailLoginButton: UIButton!
    @IBOutlet var mohaengLabel: UILabel!
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var loginStackView: UIStackView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        setLabelFont()
        setButtonUI()
        setConstraintWitouthNotch()
    }
    
    // MARK: - Functions
    
    private func setLabelFont() {
        mohaengLabel.font = .gmarketFont(weight: .bold, size: 28)
        welcomeLabel.font = .gmarketFont(weight: .light, size: 19)
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
    
    private func setConstraintWitouthNotch() {
        backgroundTopSpace.constant = UIDevice.current.hasNotch ? 0 : -70
        loginStackView.spacing = UIDevice.current.hasNotch ? 12 : 8
    }
    
    private func pushSignUpFirstViewController() {
        let signupFirstStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpFirst, bundle: nil)
        guard let signUpFirstViewController  = signupFirstStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpFirst) as? SignUpFirstViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpFirstViewController, animated: true)
    }
    
    private func pushSignUpSecondViewController() {
        let signUpSecondStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpSecond, bundle: nil)
        guard let signUpSecondViewController  = signUpSecondStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpSecond) as? SignUpSecondViewController else {
            return
        }
        
        self.navigationController?.pushViewController(signUpSecondViewController, animated: true)
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
    @IBAction func touchKakaoLoginButton(_ sender: UIButton) {
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    _ = oauthToken
                    if let accessToken = oauthToken?.accessToken {
                        self.postKakao(token: accessToken)
                    }
                    
                }
            }
        }
        // 카카오톡 미설치
        else {
            print("카카오톡 미설치")
        }
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

extension LoginViewController {
    func postKakao(token: String) {
        KakaoAPI.shared.postKakao(token: token, completion: { (response) in
            switch response {
            case .success(let message):
                UserDefaults.standard.setValue(token, forKey: "jwtToken")
                self.signUpUser.isSocial = true
                self.pushSignUpSecondViewController()
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    )}
}
