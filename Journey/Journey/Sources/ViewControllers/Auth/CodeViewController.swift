//
//  CodeViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/11.
//

import UIKit

class CodeViewController: UIViewController {
    
    // MARK: - Properties
    
    var rightCode: Int?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    
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
        completeButton.makeRounded(radius: self.completeButton.frame.height / 2)
    }
    
    private func setDelegation() {
        self.codeTextField.delegate = self
    }
    
    private func pushToNewPasswordViewController() {
        let newPasswordStoryboard = UIStoryboard(name: Const.Storyboard.Name.newPassword, bundle: nil)
        
        guard let newPasswordViewController  = newPasswordStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.newPassword) as? NewPasswordViewController else {
            return
        }
        self.navigationController?.pushViewController(newPasswordViewController, animated: true)
    }
    
    private func makeCompleteButtonEnable() {
        completeButton.isEnabled = true
        completeButton.backgroundColor = UIColor.Pink2
    }
    
    private func makeCompleteButtonDisable() {
        completeButton.isEnabled = false
        completeButton.backgroundColor = UIColor.Grey1Bg
    }
    
    func validateCode(code: String) -> Bool {
        // Email 정규식
        let emailRegEx = "^[0-9]{4}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: code)
    }
    
    private func checkCodeFormat(userInput: String) {
        if validateCode(code: userInput) {
            makeCompleteButtonEnable()
        } else {
            makeCompleteButtonDisable()
        }
    }
    
    private func checkCodeSameness(userInput: String) {
        if Int(userInput) == self.rightCode {
            pushToNewPasswordViewController()
        } else {
            errorLabel.isHidden = false
        }
    }
    
    // MARK: - @IBAction Functions

    @IBAction func touchCompleteButton(_ sender: Any) {
        guard let userInput = codeTextField.text else {
            return
        }
        checkCodeSameness(userInput: userInput)
    }
}

extension CodeViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        checkCodeFormat(userInput: text)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
    }
}
