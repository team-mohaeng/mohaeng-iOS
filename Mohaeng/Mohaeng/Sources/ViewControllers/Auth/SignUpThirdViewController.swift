//
//  SignUpThirdViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit
import Moya

class SignUpThirdViewController: UIViewController {
    
    // MARK: - Properties
    
    var signUpUser = SignUpUser.shared
    var placeholder: String?
    enum NicknameUsage: Int {
        case signUp = 0, myPage
    }
    
    var nicknameUsage: NicknameUsage?
    // MARK: - @IBOutlet Properties
    
    @IBOutlet var nickNameSetLabel: UILabel!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var nickNameBottomView: UIView!
    @IBOutlet weak var nickNameErrorLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet var nickNameConditionLabel: UILabel!
    @IBOutlet var imageToNicknameTextField: NSLayoutConstraint!
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonRound()
        checkNickNameTextField()
        divideViewControllerCase()
    }
    
    private func divideViewControllerCase() {
        switch nicknameUsage {
        case .signUp:
            setCaseSignUP()
        case .myPage:
            setCaseMyPage()
        case .none:
            break
        }
    }
    
    // MARK: - Functions
    
    private func setCaseSignUP() {
        nickNameConditionLabel.isHidden = true
        imageToNicknameTextField.constant = 40
    }
    
    private func setCaseMyPage() {
        nickNameConditionLabel.isHidden = false
        nickNameSetLabel.isHidden = true
        checkButton.setTitle("닉네임 수정하기", for: .normal)
        title = "닉네임 수정"
        setNicknameTextField()
    }
    
    private func setNicknameTextField() {
        if let nickname = self.placeholder {
            nickNameTextField.placeholder = nickname
        }
    }
    private func makeButtonRound() {
        checkButton.makeRounded(radius: 20)
    }
    
    func validateNickName(nickname: String) -> Bool {
        let nicknameRegEx = "[가-힣]{1,6}"
        let nicknameTest = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        return nicknameTest.evaluate(with: nickname)
    }
    
    func pushHomeViewController() {
        let tabbarStoryboard = UIStoryboard(name: Const.Storyboard.Name.tabbar, bundle: nil)
        guard let tabbarViewController = tabbarStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.tabbar) as? TabbarViewController else {
            return
        }
        self.changeRootViewController(tabbarViewController)
    }
    
    func changeRootViewController(_ viewControllerToPresent: UITabBarController) {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func popMyPageViewController() {
        self.navigationController?.popViewController(animated: true)
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
    @IBAction func touchNicknameCheckButton(_ sender: UIButton) {
        
        switch nicknameUsage {
        case.signUp :
            guard let isSocial = signUpUser.isSocial else {
                return
            }
            
            if isSocial {
                postSocialNickname()
            } else {
                postSignUp()
            }
        case.myPage :
            putNickname()
            
        default :
            break
        }
    }
    
}

extension SignUpThirdViewController {
    
    func postSignUp() {
        guard let email = signUpUser.email else {
            return
        }
        guard let password = signUpUser.password else {
            return
        }
        guard let nickname = nickNameTextField.text else {
            return
        }
        
        SignUpAPI.shared.postSignUp(completion: { (response) in
            switch response {
            case .success(let jwt):
                if let data = jwt as? JwtData {
                    UserDefaults.standard.setValue(data.jwt, forKey: "jwtToken")
                    self.pushHomeViewController()
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
        }, email: email, password: password, nickname: nickname)
    }
    
    func postSocialNickname() {
        guard let nickname = nickNameTextField.text else {
            return
        }
        
        KakaoAPI.shared.postSocialNickname(completion: { (response) in
            switch response {
            case .success(let jwt):
                if let data = jwt as? JwtData {
                    UserDefaults.standard.setValue(data.jwt, forKey: "jwtToken")
                    self.pushHomeViewController()
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
        },
                                           token: UserDefaults.standard.string(forKey: "jwtToken") ?? "",
                                           nickname: nickname)
    }
    
    func putNickname() {
        guard let nickname = nickNameTextField.text else {
            return
        }
     
        MyPageAPI.shared.putNickname(completion: { (response) in
            switch response {
            case .success(let jwt):
                UserDefaults.standard.set(nickname, forKey: "nickname")
                self.popMyPageViewController()
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }, nickname: nickname)
    }
}
