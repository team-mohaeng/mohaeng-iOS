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
    @IBOutlet weak var checkpasswordLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var checkingpasswordErrorLabel: UILabel!
    @IBOutlet weak var checkpasswordCheckImage: UIImageView!
    @IBOutlet weak var emailCheckImage: UIImageView!
    @IBOutlet weak var passwordCheckImage: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initHiddenAttribute()
        assignDelegate()
        initNavigationBar()
        makeButtonRound()
        
        // Strong Password 해결하려고 썼습니당.
        passwordTextField.isSecureTextEntry = false
        checkingpasswordTextField.isSecureTextEntry = false
    }
    
    // MARK: - @IBAction Function
    
    @IBAction func touchNextFirstButton(_ sender: Any) {
        signupuser.email = emailTextField.text
        signupuser.password = passwordTextField.text
        pushSignUpSecondViewController()
    }
    
    // MARK: - Functions
    
    // 처음 화면에서 체크 이미지와 확인 버튼 숨김
    private func initHiddenAttribute() {
        confirmButton.isHidden = true
        emailCheckImage.isHidden = true
        passwordCheckImage.isHidden = true
        checkpasswordCheckImage.isHidden = true
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        checkingpasswordErrorLabel.isHidden = true
    }
    
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
        emailErrorLabel.textColor = UIColor.Red
        
    }
    
    // Password Errors
    func hidePasswordError() {
        passwordCheckImage.isHidden = false
        passwordErrorLabel.isHidden = true
        
        passwordLabel.textColor = .Grey2Tab
        passwordBottomView.backgroundColor = .Grey2Tab
        
    }
    
    func showPasswordCheckError() {
        checkingpasswordErrorLabel.isHidden = false
        
        checkingpasswordErrorLabel.textColor = .Red
        checkpasswordLabel.textColor = .Red
        
    }
    
    func showPasswordCheckFormatError() {
        passwordCheckImage.isHidden = true
        passwordErrorLabel.isHidden = false
        
        passwordLabel.textColor = UIColor.Red
        passwordBottomView.backgroundColor = .Red
        passwordErrorLabel.text = "영문, 숫자를 모두 포함하여 입력해주세요"
        passwordErrorLabel.textColor = UIColor.Red
    }
    
    func showPasswordCheckBlankError() {
        passwordCheckImage.isHidden = true
        passwordErrorLabel.isHidden = true
        checkingpasswordErrorLabel.isHidden = false
        isPasswordCheckError = true
        
        passwordLabel.textColor = .Grey2Tab
        passwordBottomView.backgroundColor = .Grey2Tab
        checkingpasswordErrorLabel.textColor = .Red
        checkpasswordLabel.textColor = .Red
    }
    
    func showNotCoincideError() {
        checkpasswordCheckImage.isHidden = true
        checkingpasswordErrorLabel.isHidden = false
        passwordErrorLabel.isHidden = true
        
        passwordBottomView.backgroundColor = .Grey2Tab
        passwordLabel.textColor = .Grey2Tab
        checkpasswordLabel.textColor = .Red
        checkPasswordBottomView.backgroundColor = .Red
        checkingpasswordErrorLabel.text = "비밀번호가 일치하지 않습니다"
        checkingpasswordErrorLabel.textColor = .Red
    }
    
    func showCheckingPasswordCheckBlankError() {
        checkpasswordCheckImage.isHidden = true
        checkingpasswordErrorLabel.isHidden = true
        
        checkPasswordBottomView.backgroundColor = .Grey2Tab
        checkpasswordLabel.textColor = .Grey2Tab
    }
    
    func hidePasswordCheckError() {
        checkpasswordCheckImage.isHidden = false
        checkingpasswordErrorLabel.isHidden = true
        
        checkpasswordLabel.textColor = .Grey2Tab
        checkPasswordBottomView.backgroundColor = .Grey2Tab
    }
    
    func checkingPasswordTextCount() {
        passwordCheckImage.isHidden = true
        passwordErrorLabel.isHidden = false
        
        passwordLabel.textColor = .Red
        passwordBottomView.backgroundColor = .Red
        passwordErrorLabel.textColor = .red
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
    
    // DidEndEditing -> 손을 떼고 나서 호출
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        passwordTextField.isSecureTextEntry = true
        checkingpasswordTextField.isSecureTextEntry = true
      
        // 이메일
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
}
