//
//  LoginViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
  
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailStackView: UIStackView!
    @IBOutlet weak var passwordStackView: UIStackView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonRound()
        changeEmailStackViewAttributes()
        changePasswordStackViewAttributes()
        initNavigationBar()
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchLoginButton(_ sender: Any) {
        postLogin()
    }
    
    @IBAction func findPasswordButton(_ sender: Any) {
        pushToFindPasswordViewController()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let signupFirstStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpFirst, bundle: nil)
        
        guard let signUpFirstViewController  = signupFirstStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpFirst) as? SignUpFirstViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpFirstViewController, animated: true)
    }
    
    // MARK: - Functions
    
    private func makeButtonRound() {
        loginButton.makeRounded(radius: 20)
    }
    
    private func changeEmailStackViewAttributes() {
        emailStackView.makeRounded(radius: 10)
        emailStackView.layer.borderColor = UIColor.CourseBgGray.cgColor
        emailStackView.layer.borderWidth = 1
    }
    private func changePasswordStackViewAttributes() {
        passwordStackView.makeRounded(radius: 10)
        passwordStackView.layer.borderColor = UIColor.CourseBgGray.cgColor
        passwordStackView.layer.borderWidth = 1
    }
    private func initNavigationBar() {
        self.navigationController?.hideNavigationBar()
    }
    
    func pushToFindPasswordViewController() {
        let findPasswordStoryboard = UIStoryboard(name: Const.Storyboard.Name.findPassword, bundle: nil)
        guard let findPasswordViewController = findPasswordStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.findPassword) as? FindPasswordViewController else { return }
        
        self.navigationController?.pushViewController(findPasswordViewController, animated: true)
    }
    
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

// MARK: - Extension

extension LoginViewController {
    
    func postLogin() {
        guard let password = passwordTextField.text else {
            return
        }
    
        guard let email = emailTextField.text else {
            return
        }
        
       LoginAPI.shared.postSignIn(completion: { (response) in
            switch response {
            case .success(let jwt):
                if let data = jwt as? JwtData {
                    UserDefaults.standard.setValue(data.jwt, forKey: "jwtToken")
                    print(data.jwt)
                    self.presentHomeViewController()
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }, email: email, password: password)
    }
}
