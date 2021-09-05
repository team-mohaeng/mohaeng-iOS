//
//  SignUpFirstViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class SignUpFirstViewController: UIViewController {
    
    // MARK: - Properties
    
    var isEmailError = false
    var isPasswordError = false
    var isPasswordCheckError = false
    var signupuser = SignUpUser.shared
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var checkPasswordBottomView: UIView!
    @IBOutlet weak var passwordBottomView: UIView!
    @IBOutlet weak var emailBottomView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkingpasswordTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var checkPasswordLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var checkingPasswordErrorLabel: UILabel!
    @IBOutlet weak var checkPasswordCheckImage: UIImageView!
    @IBOutlet weak var emailCheckImage: UIImageView!
    @IBOutlet weak var passwordCheckImage: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
        initNavigationBar()
        makeButtonRound()
        resolveStrongPassoword()
        actionEmailTextField()
        actionPasswordTextField()
        actionCheckingPasswordTextField()
    }
    
    // MARK: - @IBAction Function
    
    @IBAction func touchNextFirstButton(_ sender: Any) {
        signupuser.email = emailTextField.text
        signupuser.password = passwordTextField.text
        pushSignUpSecondViewController()
    }
    
    // MARK: - Functions
    
    private func assignDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        checkingpasswordTextField.delegate = self
    }
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        navigationItem.title = "회원가입"
    }
    private func makeButtonRound() {
        confirmButton.makeRounded(radius: 20)
    }
    
    private func resolveStrongPassoword() {
        passwordTextField.isSecureTextEntry = true
        checkingpasswordTextField.isSecureTextEntry = true
    }
    
    func validateEmail(email: String) -> Bool {
        // Email 정규식
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func validatePassword(password: String) -> Bool {
        // Password 정규식
        let passwordRegEx = "(?=.*[A-Za-z])(?=.*[0-9]).{6,20}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
    
    // Email Errors
    func showEmailBlankError() {
        emailCheckImage.isHidden = true
        emailErrorLabel.isHidden = true
        
        emailLabel.textColor = .Grey2Tab
        emailBottomView.backgroundColor = .Grey2Tab
    }
    
    func hideEmailError() {
        emailErrorLabel.isHidden = true
        
        emailLabel.textColor = .Grey2Tab
        emailBottomView.backgroundColor = .Grey2Tab
    }
    
    // 이메일 정규식에 맞지 않을 때
    func showEmailFormatError() {
        emailCheckImage.isHidden = true
        
        emailLabel.textColor = .red
        emailBottomView.backgroundColor = .Red
        emailErrorLabel.isHidden = false
        emailErrorLabel.text = "이메일 형식이 올바르지 않습니다"
        emailErrorLabel.textColor = .Red
    }
    
    // Password Errors
    func hidePasswordError() {
        passwordCheckImage.isHidden = false
        passwordErrorLabel.isHidden = true
        
        passwordLabel.textColor = .Grey2Tab
        passwordBottomView.backgroundColor = .Grey2Tab
        
    }
    
    func showPasswordCheckError() {
        checkingPasswordErrorLabel.isHidden = false
        
        checkingPasswordErrorLabel.textColor = .Red
        checkPasswordLabel.textColor = .Red
        
    }
    
    func showPasswordCheckFormatError() {
        passwordCheckImage.isHidden = true
        passwordErrorLabel.isHidden = false
        
        passwordLabel.textColor = UIColor.Red
        passwordBottomView.backgroundColor = .Red
        passwordErrorLabel.text = "영문, 숫자를 모두 포함하여 입력해주세요"
        passwordErrorLabel.textColor = .Red
    }
    
    func showPasswordCheckBlankError() {
        passwordCheckImage.isHidden = true
        passwordErrorLabel.isHidden = true
        checkingPasswordErrorLabel.isHidden = false
        isPasswordCheckError = true
        
        passwordLabel.textColor = .Grey2Tab
        passwordBottomView.backgroundColor = .Grey2Tab
        checkingPasswordErrorLabel.textColor = .Red
        checkPasswordLabel.textColor = .Red
    }
    
    func showNotCoincideError() {
        checkPasswordCheckImage.isHidden = true
        checkingPasswordErrorLabel.isHidden = false
        passwordErrorLabel.isHidden = true
        
        passwordBottomView.backgroundColor = .Grey2Tab
        passwordLabel.textColor = .Grey2Tab
        checkPasswordLabel.textColor = .Red
        checkPasswordBottomView.backgroundColor = .Red
        checkingPasswordErrorLabel.text = "비밀번호가 일치하지 않습니다"
        checkingPasswordErrorLabel.textColor = .Red
    }
    
    func showCheckingPasswordCheckBlankError() {
        checkPasswordCheckImage.isHidden = true
        checkingPasswordErrorLabel.isHidden = true
        
        checkPasswordBottomView.backgroundColor = .Grey2Tab
        checkPasswordLabel.textColor = .Grey2Tab
    }
    
    func hidePasswordCheckError() {
        checkPasswordCheckImage.isHidden = false
        checkingPasswordErrorLabel.isHidden = true
        
        checkPasswordLabel.textColor = .Grey2Tab
        checkPasswordBottomView.backgroundColor = .Grey2Tab
    }
    
    func checkingPasswordTextCount() {
        passwordCheckImage.isHidden = true
        passwordErrorLabel.isHidden = false
        
        passwordLabel.textColor = .Red
        passwordBottomView.backgroundColor = .Red
        passwordErrorLabel.textColor = .Red
        passwordErrorLabel.text = "8~16자의 비밀번호를 입력해주세요"
    }
    
    func presentIsHidden() {
        emailCheckImage.isHidden = false
    }
    
    private func pushSignUpSecondViewController() {
        
        let signupSecondStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpSecond, bundle: nil)
        guard let signUpSecondViewController  = signupSecondStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpSecond) as? SignUpSecondViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpSecondViewController, animated: true)
        
    }
    
    private func actionEmailTextField() {
        emailTextField.addTarget(self, action: #selector(SignUpFirstViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    private func actionPasswordTextField() {
        passwordTextField.addTarget(self, action: #selector(SignUpFirstViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    private func actionCheckingPasswordTextField() {
        checkingpasswordTextField.addTarget(self, action: #selector(SignUpFirstViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    // MARK: @objc Function
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if passwordTextField.text!.count < 8 {
            passwordErrorLabel.textColor = .Red
        }
        if textField == emailTextField {
            self.isEmailError = checkEmail()
            
            // 비밀번호
        } else if textField == passwordTextField || textField == checkingpasswordTextField {
            self.isPasswordError = checkPassword()
            self.isPasswordCheckError = checkPasswordCheck()
        }
        // 모두 true -> 시작하기 버튼색 바꾸기
        if isEmailError && isPasswordError && isPasswordCheckError {
            self.confirmButton.backgroundColor = UIColor.DeepYellow
            confirmButton.isEnabled = true
            confirmButton.isHidden = false
            
        } else {
            confirmButton.isHidden = true
            confirmButton.isEnabled = false
        }
    }
    // MARK: - Check Functions
    
    func checkEmail() -> Bool {
        guard let email = emailTextField.text else {
            return false
        }
        // Email이 공백이 아닐 때
        if email != "" {
            // Email이 정규식에 맞지 않을 때
            if !validateEmail(email: email) {
                showEmailFormatError()
                return false
            } else {
                // Email이 정규식에 맞을 때
                hideEmailError()
                presentIsHidden()
                return true
            }
        } else {
            // Email이 공백일 때
            showEmailBlankError()
            return false
        }
    }
    
    func checkPassword() -> Bool {
        guard let password = passwordTextField.text else {
            return false
        }
        // Password가 공백이 아닐 때
        if password != "" {
            // Password가 정규식에 맞지 않을 때
            if !validatePassword(password: password) {
                if passwordTextField.text!.count > 8 {
                    self.showPasswordCheckFormatError()
                } else {
                    checkingPasswordTextCount()
                }
                return false
            } else {
                // Password가 정규식에 맞을 때
                self.hidePasswordError()
                return true
            }
        } else {
            // Password가 공백일 때
            self.showPasswordCheckBlankError()
            return false
        }
    }
    
    func checkPasswordCheck() -> Bool {
        // 비밀번호 확인
        guard let passwordCheck = checkingpasswordTextField.text else {
            return false
        }
        // 비밀번호 확인란이 공백이 아닐 때
        if passwordCheck != "" {
            // 비밀번호와 일치하지 않을 때
            guard let password = passwordTextField.text else {
                return false
            }
            if passwordCheck != password {
                self.showNotCoincideError()
                return false
            } else {
                // 비밀번호와 일치할 때
                self.hidePasswordCheckError()
                return true
            }
        } else {
            // 비밀번호 확인란이 공백일 때
            self.showCheckingPasswordCheckBlankError()
            return false
        }
    }
    
}

// MARK: - Extensions

extension SignUpFirstViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if emailTextField.isEditing {
            emailLabel.textColor = .Black1Text
            emailBottomView.backgroundColor = .black
        }
        
        if passwordTextField.isEditing {
            passwordLabel.textColor = .Black1
            passwordBottomView.backgroundColor = .black
        }
        
        if checkingpasswordTextField.isEditing {
            checkPasswordLabel.textColor = .black
            checkPasswordBottomView.backgroundColor = .black
        }
    }
}
