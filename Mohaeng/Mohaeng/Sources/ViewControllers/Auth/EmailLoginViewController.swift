//
//  SignUpFirstViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class EmailLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var signUpUser = SignUpUser.shared
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    @IBOutlet weak var emailBottomView: UIView!
    @IBOutlet weak var passwordBottonView: UIView!
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
        setButtonUI()
        initNavigationBar()
    }
    
    // MARK: - @IBAction Function
    @IBAction func touchLoginButton(_ sender: UIButton!) {
        pushHomeViewController()
      
    }
    @IBAction func touchFindPasswordButton(_ sender: UIButton!) {
        pushFindPasswordViewController()
    }
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    private func assignDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setButtonUI() {
        loginButton.makeRounded(radius: 20)
        loginButton.tintColor = .white
    }
    
    private func errorMessage() {
        errorLabel.isHidden = false
    }
    
    func finishEditingTextField() {
        emailLabel.textColor = .Grey2Text
        emailBottomView.backgroundColor = .Grey5
        passwordLabel.textColor = .Grey2Text
        passwordBottonView.backgroundColor = .Grey5
    }
    
    // rootViewController를 변경하여 화면 전환
    // 머지하고 Extension으로 뺄 예정
    func changeRootViewController(_ viewControllerToPresent: UITabBarController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    func pushHomeViewController() {
        let tabbarStoryboard = UIStoryboard(name: Const.Storyboard.Name.tabbar, bundle: nil)
        guard let tabbarViewController = tabbarStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.tabbar) as? TabbarViewController else {
            return
        }
        self.changeRootViewController(tabbarViewController)
    }
    
    func enableLoginButton() {
        loginButton.backgroundColor = .DeepYellow
        loginButton.isEnabled = true
    }
    
    private func pushFindPasswordViewController() {
        let findPasswordStoryboard = UIStoryboard(name: Const.Storyboard.Name.findPassword, bundle: nil)
        guard let findPasswordViewController = findPasswordStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.findPassword) as? FindPasswordViewController else {
            return
        }
        self.navigationController?.pushViewController(findPasswordViewController, animated: true)
    }
    
}

// MARK: - Extensions

extension EmailLoginViewController: UITextFieldDelegate {

    // Editing 하면서 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if emailTextField.isEditing {
            emailLabel.textColor = .Black1Text
            emailBottomView.backgroundColor = .black
            loginButton.backgroundColor = .DeepYellow
        }
        
        if passwordTextField.isEditing {
            passwordLabel.textColor = .Black1Text
            passwordBottonView.backgroundColor = .black
            loginButton.backgroundColor = .DeepYellow
        }
    }
    
    // Editing 끝나고 호출
    func textFieldDidEndEditing(_ textField: UITextField) {

        finishEditingTextField()
        // emailTextField, passwordTextField 둘 중 하나라도 없으면 버튼 색 바꾸기
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            loginButton.backgroundColor = .LoginYellow
            loginButton.isEnabled = false
            print(loginButton.isEnabled)
        } else {
            loginButton.isEnabled = true
            
        }
    }
}
//
//extension EmailLoginViewController {
//    func postLogin() {
//        guard let password = passwordTextField.text else {
//            return
//        }
//
//        guard let email = emailTextField.text else {
//            return
//        }
//        LoginAPI.shared.postSignIn(completion: { (response) in
//            switch response {
//            case .success(let jwt):
//                if let data = jwt as? JwtData {
//                    UserDefaults.standard.setValue(data.jwt, forKey: "jwtToken")
//                    self.enableLoginButton()
//                    self.pushHomeViewController()
//                }
//            case .requestErr(let message):
//                print("requestErr", message)
//            case .pathErr:
//                print("pathErr")
//                self.errorMessage()
//            case .serverErr:
//                print("serverErr")
//            case .networkFail:
//                print("networkFail")
//            }
//        }, email: email, password: password)
//    }
//}

