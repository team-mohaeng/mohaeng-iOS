//
//  CodeViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/11.
//

import UIKit

class CodeViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var completeButton: UIButton!
    
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        navigationItem.title = "비밀번호 찾기"
    }
    
    private func initViewRounding() {
        completeButton.makeRounded(radius: self.completeButton.frame.height / 2)
    }
    
    private func pushToNewPasswordViewController() {
        let newPasswordStoryboard = UIStoryboard(name: Const.Storyboard.Name.newPassword, bundle: nil)
        
        guard let newPasswordViewController  = newPasswordStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.newPassword) as? NewPasswordViewController else {
            return
        }
        self.navigationController?.pushViewController(newPasswordViewController, animated: true)
    }
    
    // MARK: - @IBAction Functions

    @IBAction func touchCompleteButton(_ sender: Any) {
        pushToNewPasswordViewController()
    }
}
