//
//  SignUpSecondViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class SignUpSecondViewController: UIViewController {
    
    // MARK: - Properties
    
    private var modalYearView: YearPickerViewController?
    private var currentYear: AppYear?
    private var selectedYear: AppYear?
    var signupuser = SignUpUser.shared
    // MARK: - @IBOutlet Properties**
    
    @IBOutlet weak var womanButton: UIButton!
    @IBOutlet weak var manButton: UIButton!
    @IBOutlet weak var touchNextPage2Button: UIButton!
    @IBOutlet weak var yearLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeButtonAttribute()
        makeButtonRound()
        initCurrentYear()
        //        changeNextButtonColor()
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchWomanButton(_ sender: Any) {
        womanButton.isSelected = !womanButton.isSelected
        if womanButton.isSelected == true {
            changeWomanPinkColor()
            
            if manButton.isSelected == true {
                changeManGreyColor()
                if yearLabel.text == "출생연도 선택" {
                    touchNextPage2Button.backgroundColor = UIColor.Grey1Bg
                    touchNextPage2Button.isEnabled = false
                } else {
                    touchNextPage2Button.backgroundColor = UIColor.Pink2
                    touchNextPage2Button.isEnabled = true
                }
                
            } else {
                if yearLabel.text == "출생연도 선택" {
                    touchNextPage2Button.backgroundColor = UIColor.Grey1Bg
                    touchNextPage2Button.isEnabled = false
                } else {
                    touchNextPage2Button.backgroundColor = UIColor.Pink2
                    touchNextPage2Button.isEnabled = true
                }
            }
        } else {
            changeWomanGreyColor()
            touchNextPage2Button.backgroundColor = UIColor.Grey1Bg
            touchNextPage2Button.isEnabled = false
        }
    }
    @IBAction func touchManButton(_ sender: Any) {
        manButton.isSelected = !manButton.isSelected
        if manButton.isSelected == true {
            changeManPinkColor()
            if womanButton.isSelected == true {
                changeWomanGreyColor()
                if yearLabel.text == "출생연도 선택" {
                    touchNextPage2Button.backgroundColor = UIColor.Grey1Bg
                    touchNextPage2Button.isEnabled = false
                    
                } else {
                    touchNextPage2Button.backgroundColor = UIColor.Pink2
                    touchNextPage2Button.isEnabled = true
                    
                }
            } else {
                if yearLabel.text == "출생연도 선택" {
                    touchNextPage2Button.backgroundColor = UIColor.Grey1Bg
                    
                    touchNextPage2Button.isEnabled = false
                } else {
                    touchNextPage2Button.backgroundColor = UIColor.Pink2
                    touchNextPage2Button.isEnabled = true
                    
                }
            }
            
        } else {
            changeManGreyColor()
            
            touchNextPage2Button.backgroundColor = UIColor.Grey1Bg
            touchNextPage2Button.isEnabled = false
            
        }
    }
    @IBAction func touchModalButton(_ sender: Any) {
        presentYearPickerView(year: 19)
    }
    
    @IBAction func touchNextSecondButton(_ sender: Any) {
        
        if womanButton.isSelected == true {
            signupuser.gender = 0
        } else {
            signupuser.gender = 1
        }
        signupuser.birthyear = Int(yearLabel.text!)
        
        pushSignUpThirdViewController()
    }
    
    // MARK: - Functions
    
    private func changeButtonAttribute() {
        womanButton.makeRoundedWithBorder(radius: 10, color: UIColor.lightGray.cgColor )
        manButton.makeRoundedWithBorder(radius: 10, color: UIColor.lightGray.cgColor )
    }
    
    private func makeButtonRound() {
        touchNextPage2Button.makeRounded(radius: 24)
    }
    
    private func changeManGreyColor() {
        manButton.isSelected = false
        manButton.layer.borderColor = UIColor.lightGray.cgColor
        manButton.setTitleColor(.lightGray, for: .normal)
        manButton.layer.borderWidth = 1
    }
    
    private func changeManPinkColor() {
        manButton.isSelected = true
        manButton.layer.borderColor = UIColor.HotPink.cgColor
        manButton.setTitleColor(.HotPink, for: .selected)
        manButton.layer.borderWidth = 3
    }
    
    private func changeWomanGreyColor() {
        womanButton.isSelected = false
        womanButton.layer.borderColor = UIColor.lightGray.cgColor
        womanButton.setTitleColor(.lightGray, for: .normal)
        womanButton.layer.borderWidth = 1
    }
    
    private func changeWomanPinkColor() {
        womanButton.isSelected = true
        womanButton.layer.borderColor = UIColor.HotPink.cgColor
        womanButton.setTitleColor(.HotPink, for: .selected)
        womanButton.layer.borderWidth = 3
    }
    
    private func initCurrentYear() {
        self.currentYear = AppYear()
        self.selectedYear = AppYear()
        self.modalYearView = YearPickerViewController()
        
    }
    
    private func presentYearPickerView(year: Int) {
        guard let modalYearView = self.modalYearView else { return }
        modalYearView.year = year
        modalYearView.yearPickerDataDelegate = self
        modalYearView.modalPresentationStyle = .custom
        modalYearView.transitioningDelegate = self
        self.present(modalYearView, animated: true, completion: nil)
    }
    
    private func pushSignUpThirdViewController() {
        
        let signupThirdStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpThird, bundle: nil)
        guard let signUpThirdViewController  = signupThirdStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpThird) as? SignUpThirdViewController else {
            return
        }
        self.navigationController?.pushViewController(signUpThirdViewController, animated: true)
    }
    
}

// MARK: - Extensions

// MARK: - UIPickerViewDelegate

extension SignUpSecondViewController: YearPickerViewDelegate {
    func passData(_ year: String) {
        self.selectedYear = AppYear(formattedDate: year, with: "")
        yearLabel.text = year
        yearLabel.textColor = .black
        if womanButton.isSelected || manButton.isSelected {
            touchNextPage2Button.isEnabled = true
            touchNextPage2Button.backgroundColor = UIColor.Pink2
        }
    }
    
}

// MARK: - UIViewControllerTransitioningDelegate

extension SignUpSecondViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
