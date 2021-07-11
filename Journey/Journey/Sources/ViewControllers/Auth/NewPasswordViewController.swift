//
//  NewPasswordViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/11.
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
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
    
    private func checkPasswordFormat(password: String) {
        if validatePassword(password: password) {
            errorLabel.isHidden = false
            errorLabel.text = "사용 가능한 비밀번호입니다"
            errorLabel.tintColor = UIColor.Green
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "사용 가능하지 않은 비밀번호입니다"
            errorLabel.tintColor = UIColor.Red
        }
    }
    
    private func checkPasswordSameness() {
        if passwordTextField.text == passwordCheckTextField.text {
            errorLabel.isHidden = false
            errorLabel.text = "비밀번호가 일치합니다"
            errorLabel.tintColor = UIColor.Green
            
        } else {
            errorLabel.isHidden = false
            errorLabel.text = "비밀번호가 일치하지 않습니다"
            errorLabel.tintColor = UIColor.Red
        }
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
        popToRootViewController()
    }
}

extension NewPasswordViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 비밀번호
        if passwordTextField.text != "" {
            // 비밀번호 확인
            if passwordCheckTextField.text != "" {
                checkPasswordSameness()
            } else {
                checkPasswordFormat(password: passwordTextField.text ?? "")
            }
        } else {
            if passwordCheckTextField.text != "" {
                checkPasswordSameness()
            } else {
                errorLabel.isHidden = true
            }
        }
    }
}
