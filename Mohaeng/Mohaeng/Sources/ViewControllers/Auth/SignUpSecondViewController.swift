//
//  SignUpSecondViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class SignUpSecondViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet var agreeLabel: UILabel!
    @IBOutlet var allAgreeLabel: UILabel!
    @IBOutlet var serviceLabel: UILabel!
    @IBOutlet var personalLabel: UILabel!
    @IBOutlet var eulaLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var firstCheckButton: UIButton!
    @IBOutlet var secondCheckButton: UIButton!
    @IBOutlet var thirdCheckButton: UIButton!
    @IBOutlet var fourthCheckButton: UIButton!
    @IBOutlet var agreeButton: UIButton!
    @IBOutlet var serviceButton: UIButton!
    @IBOutlet var personalButton: UIButton!
    @IBOutlet var eulaButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        initNavigationBar()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    func setButtonAttributes(button: UIButton) {
        let serviceAttribute = NSAttributedString(string: button.titleLabel?.text ?? "", attributes: [NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(weight: .regular, size: 14), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        button.setAttributedTitle(serviceAttribute, for: .normal)
    }
    
    private func setUI() {
        
        setButtonAttributes(button: serviceButton)
        setButtonAttributes(button: personalButton)
        setButtonAttributes(button: eulaButton)
        
        agreeLabel.font = .spoqaHanSansNeo(weight: .bold, size: 22)
        allAgreeLabel.font = .spoqaHanSansNeo(weight: .bold, size: 14)
        
        [serviceLabel, personalLabel, eulaLabel].forEach {
            $0.font = .spoqaHanSansNeo(weight: .regular, size: 14)
        }
        
        agreeButton.makeRounded(radius: 20)
        agreeButton.titleLabel?.font = .spoqaHanSansNeo(weight: .bold, size: 16)
    }
    
    private func setAgreeButton(color: UIColor, bool: Bool) {
        agreeButton.backgroundColor = color
        agreeButton.isEnabled = bool
    }
    
    private func pushSignUpThirdViewController() {
        let signUpThirdStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpThird, bundle: nil)
        guard let signUpThirdViewController = signUpThirdStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpThird) as?
                SignUpThirdViewController else {
                    return
                }
        signUpThirdViewController.nicknameUsage = .signUp
        self.navigationController?.pushViewController(signUpThirdViewController, animated: true)
    }
    
    private func presentAgreeViewController(agree: AgreeViewController.Agree) {
        let agreeStoryboard = UIStoryboard(name: Const.Storyboard.Name.agree, bundle: nil)
        guard let agreeViewController = agreeStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.agree) as?
                AgreeViewController else {
                    return
                }
        agreeViewController.agree = agree
        self.present(agreeViewController, animated: true, completion: nil)
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchCheckButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            sender.isSelected.toggle()
            buttons[1].isSelected = sender.isSelected
            buttons[2].isSelected = sender.isSelected
            buttons[3].isSelected = sender.isSelected
        case 1:
            sender.isSelected.toggle()
            if buttons[1].isSelected && buttons[2].isSelected && buttons[3].isSelected {
                buttons[0].isSelected = true
            } else {
                buttons[0].isSelected = false
            }
        case 2:
            sender.isSelected.toggle()
            if buttons[1].isSelected && buttons[2].isSelected && buttons[3].isSelected {
                buttons[0].isSelected = true
            } else {
                buttons[0].isSelected = false
            }
        default:
            sender.isSelected.toggle()
            if buttons[1].isSelected && buttons[2].isSelected && buttons[3].isSelected {
                buttons[0].isSelected = true
            } else {
                buttons[0].isSelected = false
            }
        }
        
        let first = firstCheckButton.isSelected
        let second = secondCheckButton.isSelected
        let third = thirdCheckButton.isSelected
        let fourth = fourthCheckButton.isSelected
        
        if first && second && third && fourth {
            setAgreeButton(color: .DeepYellow, bool: true)
        } else {
            setAgreeButton(color: .LoginYellow, bool: false)
        }
    }
    
    @IBAction func touchAgreeButton(_ sender: UIButton) {
        pushSignUpThirdViewController()
    }
    
    @IBAction func presentServiceWeb(_ sender: UIButton) {
        presentAgreeViewController(agree: AgreeViewController.Agree.service)
    }
    
    @IBAction func presentPersonalWeb(_ sender: UIButton) {
        presentAgreeViewController(agree: AgreeViewController.Agree.personal)
    }
    @IBAction func presentEULAWeb(_ sender: UIButton) {
        presentAgreeViewController(agree: AgreeViewController.Agree.eula)
    }
}
