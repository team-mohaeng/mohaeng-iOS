//
//  SignUpThirdViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class SignUpThirdViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var inputNicknameTextField: UITextField!
    @IBOutlet weak var touchNextPage3Button: UIButton!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var nicknameErrorLabel: UILabel!
    var signupuser = SignUpUser.shared
    var isNickNameError = false
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUnderLineinputNicknameTextField()
        makeButton3Round()
        chgangeTextAttribute()
        setDelegation()
        initNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeUnderLineinputNicknameTextField()
        
    }
    
    @IBAction func touchNextButton(_ sender: Any) {
        
        postSignUp()
        
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        navigationItem.title = "회원가입"
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
    
    func showNickNameBlankError() {
        nicknameErrorLabel.isHidden = false
        nicknameErrorLabel.text = "사용 가능하지 않은 닉네임입니다"
        nicknameErrorLabel.textColor = UIColor.red
        isNickNameError = true
    }
    
    func hideNickNameError() {
        nicknameErrorLabel.isHidden = false
        nicknameErrorLabel.text = "사용가능한 닉네임입니다"
        nicknameErrorLabel.textColor = UIColor.green
        isNickNameError = false
    }
    
    func showNickNameFormatError() {
        nicknameErrorLabel.isHidden = false
        nicknameErrorLabel.text = "사용 가능하지 않은 닉네임입니다"
        nicknameErrorLabel.textColor = UIColor.red
        isNickNameError = true
    }
    
    private func setDelegation() {
        self.inputNicknameTextField.delegate = self
    }
    
    private func chgangeTextAttribute() {
        //serviceLabel 텍스트 가져오기
        guard let text = self.serviceLabel.text else { return }
        
        // 인스턴스 만들어주기
        let attributeString = NSMutableAttributedString(string: text)
        
        // 크기 폰트 생성
        let font = UIFont.boldSystemFont(ofSize: 10)
        
        // 내가 원하는 텍스트에만 적용
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "서비스 이용 약관"))
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "개인정보 보호정책"))
        
        // 밑줄 색
        attributeString.addAttribute(.underlineColor, value: UIColor.black, range: (text as NSString).range(of: "서비스 이용 약관"))
        attributeString.addAttribute(.underlineColor, value: UIColor.black, range: (text as NSString).range(of: "개인정보 보호정책"))
        
        // 밑줄 두께
        attributeString.addAttribute(.underlineStyle, value: 1, range: (text as NSString).range(of: "서비스 이용 약관"))
        attributeString.addAttribute(.underlineStyle, value: 1, range: (text as NSString).range(of: "개인정보 보호정책"))
        
        // 속성 적용
        self.serviceLabel.attributedText = attributeString
        
    }
    func validateNickName(nickname: String) -> Bool {
        // 닉네임 정규식
        let nicknameRegEx = "[가-힣]{1,6}"
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        return nicknameTest.evaluate(with: nickname)
    }
    
    func popToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func checkNickName() -> Bool {
        guard let nickname = inputNicknameTextField.text else {
            return false
        }
        // 닉네임이 공백이 아닐 때
        if nickname != "" {
            // 닉네임이 정규식에 맞지 않을 때
            if !validateNickName(nickname: nickname) {
                showNickNameFormatError()
                return false
            } else {
                // 닉네임이 정규식에 맞을 때
                hideNickNameError()
                return true
            }
        } else {
            // 닉네임이 공백일 때
            showNickNameBlankError()
            return false
        }
    }
}

extension SignUpThirdViewController {
    func postSignUp() {
        guard let email = signupuser.email else {
            return
        }
        guard let password = signupuser.password else {
            return
        }
        guard let gender = signupuser.gender else {
            return
        }
        guard let birthyear = signupuser.birthyear else {
            return
        }
        guard let nickname = inputNicknameTextField.text else {
            return
        }
        SignUpAPI.shared.postSignUp(completion: { (response) in
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
        }, email: email, password: password, nickname: nickname, gender: gender, birthyear: birthyear)
    }
}

// MARK: - Extensions

extension SignUpThirdViewController: UITextFieldDelegate {
    
    // DidEndEditing -> 손을 떼고 나서 호출
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        if checkNickName() {
            self.touchNextPage3Button.backgroundColor = UIColor.Pink2
            touchNextPage3Button.isEnabled = true
        } else {
            self.touchNextPage3Button.backgroundColor = UIColor.Grey1Bg
            touchNextPage3Button.isEnabled = false
        }
    }
    
}
