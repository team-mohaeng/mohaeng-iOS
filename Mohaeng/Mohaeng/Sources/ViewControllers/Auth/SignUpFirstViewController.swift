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
    var signUpUser = SignUpUser.shared
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var checkOverlapButton: UIButton!
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
        setButton()
        resolveStrongPassoword()
        actionEmailTextField()
        actionPasswordTextField()
        actionCheckingPasswordTextField()
    }
    
    // MARK: - @IBAction Function
    
    @IBAction func touchNextFirstButton(_ sender: Any) {
        signUpUser.email = emailTextField.text
        signUpUser.password = passwordTextField.text
        signUpUser.isSocial = false
        pushSignUpSecondViewController()
    }
    @IBAction func touchOverlapButton(_ sender: UIButton) {
        postEmailCheck()
    }
    
    // MARK: - Functions
    
    private func assignDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        checkingpasswordTextField.delegate = self
    }
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    private func setButton() {
        confirmButton.makeRounded(radius: 20)
        checkOverlapButton.makeRounded(radius: 14)
        checkOverlapButton.titleLabel?.font = .spoqaHanSansNeo(weight: .bold, size: 12)
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
        emailLabel.textColor = .Grey2
        emailBottomView.backgroundColor = .Grey5
    }
    func hideEmailError() {
        emailErrorLabel.isHidden = true
        emailLabel.textColor = .Grey2
        emailBottomView.backgroundColor = .Black
    }
    // 이메일 정규식에 맞지 않을 때
    func showEmailFormatError() {
        emailCheckImage.isHidden = true
        emailLabel.textColor = .red
        emailBottomView.backgroundColor = .Red
        emailErrorLabel.isHidden = false
        emailErrorLabel.text = "이메일 형식이 올바르지 않습니다"
        emailErrorLabel.textColor = .Red
        confirmButton.isEnabled = false
        emailCheckImage.isHidden = true
        confirmButton.isHidden = true
    }
    // Password Errors
    func hidePasswordError() {
        passwordCheckImage.isHidden = false
        passwordErrorLabel.isHidden = true
        passwordLabel.textColor = .Grey2
        passwordBottomView.backgroundColor = .Black
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
        passwordLabel.textColor = .Grey2
        passwordBottomView.backgroundColor = .Grey5
        checkingPasswordErrorLabel.textColor = .Red
        checkPasswordLabel.textColor = .Red
        confirmButton.isEnabled = false
        confirmButton.isHidden = true
    }
    func showNotCoincideError() {
        confirmButton.isHidden = true
        checkPasswordCheckImage.isHidden = true
        checkingPasswordErrorLabel.isHidden = false
        passwordErrorLabel.isHidden = true
        passwordBottomView.backgroundColor = .Black
        passwordLabel.textColor = .Grey2
        checkPasswordLabel.textColor = .Red
        checkPasswordBottomView.backgroundColor = .Red
        checkingPasswordErrorLabel.text = "비밀번호가 일치하지 않습니다"
        checkingPasswordErrorLabel.textColor = .Red
    }
    func showCheckingPasswordCheckBlankError() {
        checkPasswordCheckImage.isHidden = true
        checkingPasswordErrorLabel.isHidden = true
        checkPasswordBottomView.backgroundColor = .Grey5
        checkPasswordLabel.textColor = .Grey2
        confirmButton.isEnabled = false
        confirmButton.isHidden = true
    }
    func hidePasswordCheckError() {
        checkPasswordCheckImage.isHidden = false
        checkingPasswordErrorLabel.isHidden = true
        checkPasswordLabel.textColor = .Grey2
        checkPasswordBottomView.backgroundColor = .Grey2
    }
    func checkingPasswordTextCount() {
        passwordCheckImage.isHidden = true
        passwordErrorLabel.isHidden = false
        passwordLabel.textColor = .Red
        passwordBottomView.backgroundColor = .Red
        passwordErrorLabel.textColor = .Red
        passwordErrorLabel.text = "8~16자의 비밀번호를 입력해주세요"
    }
    func changeAttributesSuccess() {
        guard let passwordCheck = checkingpasswordTextField.text else {
            return
        }
        if passwordCheck != "" {
            guard let password = passwordTextField.text else {
                return
            }
            if passwordCheck != password {
                showNotCoincideError()
            } else {
                hidePasswordCheckError()
            }
        } else {
            showCheckingPasswordCheckBlankError()
        }
        emailCheckImage.isHidden = false
        if isPasswordError && isPasswordCheckError {
            confirmButton.backgroundColor = UIColor.DeepYellow
            confirmButton.isEnabled = true
            confirmButton.isHidden = false
            emailCheckImage.isHidden = false
        } else {
            self.confirmButton.isHidden = true
            self.confirmButton.isEnabled = false
        }
        guard let email = emailTextField.text else {
            return
        }
        if email != "" {
            if !validateEmail(email: email) {
                showEmailFormatError()
            } else {
                hideEmailError()
            }
        } else {
            showEmailBlankError()
        }
    }
    func changeAttributesRequestErr() {
        guard let email = emailTextField.text else { return }
        if email == "" {
            emailErrorLabel.isHidden = true
        } else {
            emailErrorLabel.isHidden = false
            confirmButton.isEnabled = false
            confirmButton.isHidden = true
            emailCheckImage.isHidden = true
            emailLabel.textColor = .Red
            emailBottomView.backgroundColor = .Red
        }
    }
    private func changeTextFieldAttribute(label: UILabel, view: UIView) {
        label.textColor = .black
        view.backgroundColor = .Black
    }
    private func pushSignUpSecondViewController() {
        let signUpSecondStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpSecond, bundle: nil)
        guard let signUpSecondViewController  = signUpSecondStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpSecond) as? SignUpSecondViewController else {
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
        guard let password = passwordTextField.text else { return }
        guard let email = emailTextField.text else {return}
        if email.count < 1 {
            confirmButton.isEnabled = false
        } else {
            confirmButton.isEnabled = true
        }
        if password.count < 8 {
            passwordErrorLabel.textColor = .Red
        }
        if textField == emailTextField {
            self.isEmailError = checkEmail()
            
        } else if textField == passwordTextField || textField == checkingpasswordTextField {
            self.isPasswordError = checkPassword()
            self.isPasswordCheckError = checkPasswordCheck()
        }
        
        if confirmButton.isEnabled && isPasswordError && isPasswordCheckError {
            postEmailCheck()
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
                if password.count > 8 {
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
            changeTextFieldAttribute(label: emailLabel, view: emailBottomView)
        }
        if passwordTextField.isEditing {
            changeTextFieldAttribute(label: passwordLabel, view: passwordBottomView)
        }
        if checkingpasswordTextField.isEditing {
            changeTextFieldAttribute(label: checkPasswordLabel, view: checkPasswordBottomView)
        }
    }
}
extension SignUpFirstViewController {
    func postEmailCheck() {
        guard let email = emailTextField.text else { return }
        SignUpAPI.shared.postEmailCheck(completion: { [self] (response) in
            switch response {
            case .success(let message):
                print("success")
                changeAttributesSuccess()
            case .requestErr(let message):
                print("requestErr", message)
                if let message = message as? String {
                    changeAttributesRequestErr()
                    emailErrorLabel.text = message
                }
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }, email: email)
    }
}
