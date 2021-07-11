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
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkingpasswordTextField: UITextField!
    @IBOutlet weak var emailCheckErrorLabel: UILabel!
    @IBOutlet weak var passwordCheckErrorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
        initNavigationBar()
        initErrorLabel()
        makeUnderLineEmailTextField()
        makeUnderLinePasswordTextField()
        makeUnderLineCheckPasswordTextField()
        makeButtonRound()
    }
    
    // MARK: - @IBAction Function
    
    @IBAction func touchNextFirstButton(_ sender: Any) {
        let signupSecondStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpSecond, bundle: nil)

        guard let signUpSecondViewController  = signupSecondStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpSecond) as? SignUpSecondViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpSecondViewController, animated: true)
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
    
    private func initErrorLabel() {
        
        // 처음 뷰 로드 시 error laber hidden 처리
        emailCheckErrorLabel.isHidden = true
        passwordCheckErrorLabel.isHidden = true
    }
    
    private func makeUnderLineEmailTextField() {
        // 텍스트필드 밑줄 남기기
        emailTextField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: emailTextField.frame.size.height-1, width: emailTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        emailTextField.layer.addSublayer((border))
        emailTextField.textColor = UIColor.black
    }
    
    private func makeUnderLinePasswordTextField() {
        // 텍스트필드 밑줄 남기기
        passwordTextField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: passwordTextField.frame.size.height-1, width: passwordTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        passwordTextField.layer.addSublayer((border))
        passwordTextField.textColor = UIColor.black
    }
    
    private func makeUnderLineCheckPasswordTextField() {
        // 텍스트필드 밑줄 남기기
        checkingpasswordTextField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: checkingpasswordTextField.frame.size.height-1, width: checkingpasswordTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        checkingpasswordTextField.layer.addSublayer((border))
        checkingpasswordTextField.textColor = UIColor.black
    }
    
    private func makeButtonRound() {
        nextButton.makeRounded(radius: 24)
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
        emailCheckErrorLabel.isHidden = false
        emailCheckErrorLabel.text = "사용 가능하지 않은 이메일입니다"
        emailCheckErrorLabel.textColor = UIColor.red
        isEmailError = true
    }
    
    func hideEmailError() {
        emailCheckErrorLabel.isHidden = false
        emailCheckErrorLabel.text = "사용가능한 이메일입니다"
        emailCheckErrorLabel.textColor = UIColor.green
        isEmailError = false
    }
    
    func showEmailFormatError() {
        emailCheckErrorLabel.isHidden = false
        emailCheckErrorLabel.text = "사용 가능하지 않은 이메일입니다"
        emailCheckErrorLabel.textColor = UIColor.red
    }
    
    // Password Errors
    func hidePasswordError() {
        passwordCheckErrorLabel.isHidden = false
        passwordCheckErrorLabel.text = "사용 가능한 비밀번호입니다"
        passwordCheckErrorLabel.textColor = UIColor.green
        isPasswordError = false
    }
    
    func showPasswordCheckFormatError() {
        passwordCheckErrorLabel.isHidden = false
        passwordCheckErrorLabel.text = "비밀번호가 일치하지 않습니다"
        passwordCheckErrorLabel.textColor = UIColor.red
        
        isPasswordCheckError = true
        
    }
    
    func showPasswordCheckBlankError() {
        passwordCheckErrorLabel.isHidden = false
        passwordCheckErrorLabel.text = "사용 가능한 비밀번호입니다."
        passwordCheckErrorLabel.textColor = UIColor.green
        isPasswordCheckError = true
    }
    
    func hidePasswordCheckError() {
        passwordCheckErrorLabel.isHidden = false
        passwordCheckErrorLabel.text = "비밀번호가 일치합니다"
        passwordCheckErrorLabel.textColor = UIColor.green
        isPasswordCheckError = false
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
                self.showPasswordCheckFormatError()
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
                self.showPasswordCheckFormatError()
                return false
            } else {
                // 비밀번호와 일치할 때
                self.hidePasswordCheckError()
                return true
            }
        } else {
            // 비밀번호 확인란이 공백일 때
            self.showPasswordCheckBlankError()
            return false
        }
    }
    
}

// MARK: - Extensions

extension SignUpFirstViewController: UITextFieldDelegate {
    
    // DidEndEditing -> 손을 떼고 나서 호출
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
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
            self.nextButton.backgroundColor = UIColor.HotPink
            nextButton.isEnabled = true
        } else {
            self.nextButton.backgroundColor = UIColor.CourseBgGray
            nextButton.isEnabled = false
        }
    }
    
}
