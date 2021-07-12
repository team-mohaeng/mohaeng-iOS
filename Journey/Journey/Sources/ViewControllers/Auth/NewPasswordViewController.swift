//
//  NewPasswordViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/11.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    // MARK: - Properties
    
    var user = User.shared
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initViewRounding()
        setDelegation()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        navigationItem.title = "비밀번호 찾기"
    }
    
    private func initViewRounding() {
        completeButton.makeRounded(radius: completeButton.frame.height / 2)
    }
    
    private func setDelegation() {
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
    }
    
    private func showFormatError() {
        errorLabel.isHidden = false
        errorLabel.text = "사용 가능하지 않은 비밀번호입니다"
        errorLabel.textColor = UIColor.Red
        makeCompleteButtonDisable()
    }
    
    private func hideFormatError() {
        errorLabel.isHidden = false
        errorLabel.text = "사용 가능한 비밀번호입니다"
        errorLabel.textColor = UIColor.Green
        makeCompleteButtonDisable()
    }
    
    private func checkPasswordSameness() {
        if passwordTextField.text == passwordCheckTextField.text {
            errorLabel.isHidden = false
            errorLabel.text = "비밀번호가 일치합니다"
            errorLabel.textColor = UIColor.Green
            makeCompleteButtonEnable()
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "비밀번호가 일치하지 않습니다"
            errorLabel.textColor = UIColor.Red
            makeCompleteButtonDisable()
        }
    }
    
    private func makeCompleteButtonEnable() {
        completeButton.isEnabled = true
        completeButton.backgroundColor = UIColor.Pink2
    }
    
    private func makeCompleteButtonDisable() {
        completeButton.isEnabled = false
        completeButton.backgroundColor = UIColor.Grey1Bg
    }
    
    func validatePassword(password: String) -> Bool {
        // Password 정규식
        let passwordRegEx = "(?=.*[A-Za-z])(?=.*[0-9]).{8,16}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return predicate.evaluate(with: password)
    }
    
    func popToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - @IBAction Functions
    
    @IBAction func touchCompleteButton(_ sender: Any) {
        putNewPassword()
    }
}

extension NewPasswordViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let password = passwordTextField.text  else {
            return
        }

        // 비밀번호
        if password != "" {
            
            if validatePassword(password: password) {
                if passwordCheckTextField.text != "" {
                    checkPasswordSameness()
                } else {
                    hideFormatError()
                }
            } else {
                showFormatError()
            }
        } else {
            errorLabel.isHidden = true
        }
    }
}

extension NewPasswordViewController {
    func putNewPassword() {
        
        guard let password = passwordTextField.text else {
            return
        }
        user.password = password
        
        guard let email = user.email else {
            return
        }
        
        PasswordAPI.shared.putNewPassword(completion: { (response) in
            switch response {
            case .success(let jwt):
                if let data = jwt as? JwtData {
                    self.popToRootViewController()
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
