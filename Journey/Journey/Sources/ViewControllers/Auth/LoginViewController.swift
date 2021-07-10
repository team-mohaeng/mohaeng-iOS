//
//  LoginViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        self.passwordTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonRound()
        initNavigationBar()
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchLoginButton(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            let tabbarStoryboard = UIStoryboard(name: Const.Storyboard.Name.tabbar, bundle: nil)
            guard let tabbarViewController = tabbarStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.tabbar) as? TabbarViewController else {
                return
            }
            tabbarViewController.modalPresentationStyle = .fullScreen
            tabbarViewController.modalTransitionStyle = .crossDissolve
            self.present(tabbarViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func findPasswordButton(_ sender: Any) {
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let signupFirstStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpFirst, bundle: nil)
        
        guard let signUpFirstViewController  = signupFirstStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpFirst) as? SignUpFirstViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpFirstViewController, animated: true)
    }
    
    // MARK: - Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passwordTextField.resignFirstResponder()
    }
    
    private func makeButtonRound() {
        loginButton.makeRounded(radius: 20)
    }
    
    private func initNavigationBar() {
        self.navigationController?.hideNavigationBar()
    }
    
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func passwordTextFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.passwordTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        return true
    }
}
