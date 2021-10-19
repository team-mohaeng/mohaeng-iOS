//
//  EditNicknameViewController.swift
//  Mohaeng
//
//  Created by 김승찬 on 2021/10/19.
//

import UIKit

class EditNicknameViewController: UIViewController {

    @IBOutlet var nicknameErrorLabel: UILabel!
    @IBOutlet var nicknameBottomView: UIView!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var editNicknameButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonRound()
        checkNickNameTextField()
    }
    
    private func makeButtonRound() {
        editNicknameButton.makeRounded(radius: 20)
    }

    func validateNickName(nickname: String) -> Bool {
        let nicknameRegEx = "[가-힣]{1,6}"
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        return nicknameTest.evaluate(with: nickname)
    }

    private func changeNickNameTextFieldAttribute(labelBool: Bool, buttonBool: Bool, color: UIColor) {
        nicknameErrorLabel.isHidden = labelBool
        editNicknameButton.isHidden = buttonBool
        nicknameBottomView.backgroundColor = color
    }

    private func validateNickNameTextField() {
        changeNickNameTextFieldAttribute(labelBool: true, buttonBool: false, color: .Black)
    }

    private func invalidateNickNameTextField() {
        changeNickNameTextFieldAttribute(labelBool: false, buttonBool: true, color: .Red)
    }

    private func setEmptyNickNameTextField() {
        changeNickNameTextFieldAttribute(labelBool: true, buttonBool: true, color: .Grey3)
    }

    private func checkNickNameTextField() {
        nicknameTextField.addTarget(self, action: #selector(SignUpThirdViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }

    // MARK: @objc Function

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let nickname = nicknameTextField.text else { return }
        if nickname.count < 7 {
            if !validateNickName(nickname: nickname) {
                invalidateNickNameTextField()
            } else {
                validateNickNameTextField()
            }
        } else {
            invalidateNickNameTextField()
        }
        if nickname.isEmpty {
            setEmptyNickNameTextField()
        }
    }
    
    @IBAction func touchEditNicknameButton(_ sender: UIButton) {
   
    }
}
