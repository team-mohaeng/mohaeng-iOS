//
//  SignUpThirdViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class SignUpThirdViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameBottomView: UIView!
    @IBOutlet weak var nickNameErrorLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonRound()
        checkNickNameTextField()
    }
    
    // MARK: - Functions
    
    private func makeButtonRound() {
        checkButton.makeRounded(radius: 20)
    }
    
    func validateNickName(nickname: String) -> Bool {
        let nicknameRegEx = "[가-힣]{1,6}"
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        return nicknameTest.evaluate(with: nickname)
    }
    
    private func pushHomeViewController() {
        let homeStoryboard = UIStoryboard(name: Const.Storyboard.Name.home, bundle: nil)
        guard let homeViewController  = homeStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.home) as? HomeViewController else {
            return
        }
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    private func changeNickNameTextFieldAttribute(labelBool: Bool, buttonBool: Bool, color: UIColor) {
        nickNameErrorLabel.isHidden = labelBool
        checkButton.isHidden = buttonBool
        nickNameBottomView.backgroundColor = color
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
        nickNameTextField.addTarget(self, action: #selector(SignUpThirdViewController.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    // MARK: @objc Function
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let nickname = nickNameTextField.text else { return }
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
}
