//
//  SignUpFirstViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class EmailLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var signupuser = SignUpUser.shared
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var doLoginButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
        makeButtonRound()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeUnderLineEmailTextField()
        makeUnderLinePasswordTextField()
    }
    
    // MARK: - @IBAction Function
    @IBAction func touchLoginButton(_ sender: Any) {
        pushHomeViewController()
        
    }
    @IBAction func touchFindPasswordButton(_ sender: Any) {
        
    }
    // MARK: - Functions
    
    private func assignDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func makeUnderLineEmailTextField() {
        emailTextField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: emailTextField.frame.size.height-1, width: emailTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.Grey1Line.cgColor
        emailTextField.layer.addSublayer((border))
        emailTextField.textColor = UIColor.Black1Text
    }
    
    private func makeUnderLinePasswordTextField() {
        passwordTextField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: passwordTextField.frame.size.height-1, width: passwordTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.Grey1Line.cgColor
        passwordTextField.layer.addSublayer((border))
        passwordTextField.textColor = UIColor.Black1Text
    }
    
    private func makeButtonRound() {
        doLoginButton.makeRounded(radius: 20)
    }
    
    private func errorMessage() {
        errorLabel.isHidden = false
    }
    
    func pushHomeViewController() {
        doLoginButton.isEnabled = true
        
        let homeStoryboard = UIStoryboard(name: Const.Storyboard.Name.home, bundle: nil)
        guard let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.home) as? HomeViewController else {
            return
        }
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    private func pushSignUpSecondViewController() {
        // 비밀번호 찾기 뷰 나오면 넣어 놓을게용
    }
    
}

// MARK: - Extensions

extension EmailLoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if emailTextField.text == "" {
            emailLabel.textColor = .Grey2Text
            errorLabel.isHidden = true
            doLoginButton.backgroundColor = .LoginYellow
            
        } else {
            emailLabel.textColor = .Black1Text
            doLoginButton.backgroundColor = .DeepYellow
        }
        
        if passwordTextField.text == "" {
            passwordLabel.textColor = .Grey2Text
            errorLabel.isHidden = true
            doLoginButton.backgroundColor = .LoginYellow
            
        } else {
            passwordLabel.textColor = .Black1Text
            doLoginButton.backgroundColor = .DeepYellow
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        emailLabel.textColor = .Grey2Text
        passwordLabel.textColor = .Grey2Text
    }
    
}

extension EmailLoginViewController {
    
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
                    self.pushHomeViewController()
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
                self.errorMessage()
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }, email: email, password: password)
    }
}
