//
//  SignUpFirstViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class EmailLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var signUpUser = SignUpUser.shared
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var findPasswordButton: UIButton!
    @IBOutlet weak var emailBottomView: UIView!
    @IBOutlet weak var passwordBottomView: UIView!
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
        setButtonUI()
        initNavigationBar()
    }
    
    // MARK: - @IBActions
    
    @IBAction func touchLoginButton(_ sender: UIButton!) {
        pushHomeViewController()
      
    }
    @IBAction func touchFindPasswordButton(_ sender: UIButton!) {
        pushFindPasswordViewController()
    }
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    private func assignDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setButtonUI() {
        loginButton.makeRounded(radius: 20)
        loginButton.tintColor = .white
    }
    
    private func errorMessage() {
        errorLabel.isHidden = false
    }
    
    func finishEditingTextField() {
        emailLabel.textColor = .Grey2Text
        emailBottomView.backgroundColor = .Grey5
        passwordLabel.textColor = .Grey2Text
        passwordBottomView.backgroundColor = .Grey5
    }
    
    func changeRootViewController(_ viewControllerToPresent: UITabBarController) {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func pushHomeViewController() {
        let tabbarStoryboard = UIStoryboard(name: Const.Storyboard.Name.tabbar, bundle: nil)
        guard let tabbarViewController = tabbarStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.tabbar) as? TabbarViewController else {
            return
        }
        self.changeRootViewController(tabbarViewController)
    }
    
    func enableLoginButton() {
        loginButton.backgroundColor = .DeepYellow
        loginButton.isEnabled = true
    }
    
    func changeEditingTextField(label: UILabel, bottomView: UIView) {
        label.textColor = .Black1Text
        bottomView.backgroundColor = .black
        loginButton.backgroundColor = .DeepYellow
    }
    
    private func pushFindPasswordViewController() {
        let findPasswordStoryboard = UIStoryboard(name: Const.Storyboard.Name.findPassword, bundle: nil)
        guard let findPasswordViewController = findPasswordStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.findPassword) as? FindPasswordViewController else {
            return
        }
        self.navigationController?.pushViewController(findPasswordViewController, animated: true)
    }
    
}

// MARK: - Extensions

extension EmailLoginViewController: UITextFieldDelegate {

    // Editing 하면서 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if emailTextField.isEditing {
            changeEditingTextField(label: emailLabel, bottomView: emailBottomView)
        }
        
        if passwordTextField.isEditing {
            changeEditingTextField(label: passwordLabel, bottomView: passwordBottomView)
        }
    }
    
    // Editing 끝나고 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        finishEditingTextField()
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        // emailTextField, passwordTextField 둘 중 하나라도 없으면 버튼 색 바꾸기
        if email.isEmpty || password.isEmpty {
            loginButton.backgroundColor = .LoginYellow
            loginButton.isEnabled = false
        } else {
            loginButton.isEnabled = true
        }
    }
}
