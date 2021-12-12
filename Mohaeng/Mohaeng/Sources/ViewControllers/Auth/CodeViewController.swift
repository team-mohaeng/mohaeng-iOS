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
    @IBOutlet weak var underlineView: UIView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initViewRounding()
        setDelegation()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
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
        completeButton.alpha = 1.0
    }
    
    private func makeCompleteButtonDisable() {
        completeButton.isEnabled = false
        completeButton.alpha = 0.3
    }
    
    func validateCode(code: String) -> Bool {
        // Email 정규식
        let codeRegEx = "^[0-9]{4}$"
        let codeTest = NSPredicate(format: "SELF MATCHES %@", codeRegEx)
        return codeTest.evaluate(with: code)
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
            underlineView.backgroundColor = UIColor.red
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
        underlineView.backgroundColor = UIColor.Grey1Line
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
        underlineView.backgroundColor = UIColor.Black1
    }
}
