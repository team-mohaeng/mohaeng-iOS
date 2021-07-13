//
//  PopUpViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import UIKit

protocol PopUpActionDelegate {
    func touchPinkButton(button: UIButton)
    func touchWhiteButton(button: UIButton)
}

class PopUpViewController: UIViewController {
    
    // MARK: - Properties
    
    enum PopUpUsage: Int {
        case oneButton = 0, twoButton, oneButtonWithClose, noImage, noTitle
    }
    
    var popUpUsage: PopUpUsage?
    var popUpActionDelegate: PopUpActionDelegate?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var popUpBgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popUpImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pinkButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // constraints
    
    @IBOutlet weak var pinkButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var whiteButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewRounding()
        initCase(usage: self.popUpUsage ?? .oneButton)
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        popUpBgView.makeRounded(radius: 10)
        pinkButton.makeRounded(radius: pinkButton.frame.height / 2)
        whiteButton.makeRounded(radius: whiteButton.frame.height / 2)
    }

    @IBAction func touchPinkButton(_ sender: UIButton) {
        self.popUpActionDelegate?.touchPinkButton(button: sender)
    }
    
    @IBAction func touchWhiteButton(_ sender: UIButton) {
        self.popUpActionDelegate?.touchPinkButton(button: sender)
    }
    
    @IBAction func touchCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // case functions
    
    private func initCase(usage: PopUpUsage) {
        switch usage {
        case .oneButton:
            self.initCaseOneButton()
        case .twoButton:
            self.initCaseTwoButton()
        case .oneButtonWithClose:
            self.initCaseOneButtonWithClose()
        case .noImage:
            self.initCaseNoIamge()
        case .noTitle:
            self.initCaseNoTitle()
        }
    }
    
    private func initCaseOneButton() {
        whiteButton.isHidden = true
        closeButton.isHidden = true
        whiteButtonHeightConstraint.isActive = false
        pinkButtonBottomConstraint.constant = 24
    }
    
    private func initCaseTwoButton() {
        closeButton.isHidden = true
        pinkButtonBottomConstraint.isActive = false
    }
    
    private func initCaseOneButtonWithClose() {
        whiteButton.isHidden = true
        whiteButtonHeightConstraint.isActive = false
        pinkButtonBottomConstraint.constant = 24
    }
    
    private func initCaseNoIamge() {
        closeButton.isHidden = true
        descriptionTopConstraint.constant = 93
        popUpImageView.removeFromSuperview()
    }
    
    private func initCaseNoTitle() {
        whiteButton.isHidden = true
        closeButton.isHidden = true
        pinkButtonBottomConstraint.constant = 24
        descriptionTopConstraint.constant = 48
        
        titleLabel.removeFromSuperview()
        popUpImageView.removeFromSuperview()
        whiteButton.removeFromSuperview()
    }
    
    // set functions
    
    func setTitle(text: String) {
        titleLabel.text = text
    }
}
