//
//  SignUpThirdViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class SignUpThirdViewController: UIViewController {
    @IBOutlet weak var inputNicknameTextField: UITextField!
    @IBOutlet weak var touchNextPage3Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUnderLineinputNicknameTextField()
        makeButton3Round()
        dddddd()
    }
    
    private func makeUnderLineinputNicknameTextField() {
        inputNicknameTextField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: inputNicknameTextField.frame.size.height-1, width: inputNicknameTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        inputNicknameTextField.layer.addSublayer((border))
        inputNicknameTextField.textColor = UIColor.black
    }
    
    private func makeButton3Round() {
        touchNextPage3Button.makeRounded(radius: 24)
    }
    
    private func dddddd() {
        if inputNicknameTextField.text != "" {
            //Delegate -> Edit함수
            
            
        }
    }
    


}
