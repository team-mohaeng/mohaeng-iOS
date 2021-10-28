//
//  PopUpViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import UIKit

class PopUpViewController: UIViewController {
    
    // MARK: - Properties
    
    enum PopUpUsage: Int {
        case noButton = 0, twoButtonNoImage, twoButtonWithImage
    }
    
    var popUpUsage: PopUpUsage?
    var popUpActionDelegate: PopUpActionDelegate?
    var image: UIImage?
    
    // text
    var titleString: String?
    var descriptionString: String?
    var buttonString: String?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var popUpBgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popUpImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var greyButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    // constraints
    @IBOutlet weak var descriptionToBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionToStackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleToDescriptionConstraint: NSLayoutConstraint!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewRounding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initCase(usage: self.popUpUsage ?? .noButton)
        setText()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        popUpBgView.makeRounded(radius: 30)
        greyButton.makeRounded(radius: 6)
        yellowButton.makeRounded(radius: 6)
    }
    
    private func setText() {
        if let titleString = self.titleString {
            titleLabel.text = titleString
        }
        if let descriptionString = self.descriptionString {
            descriptionLabel.text = descriptionString
        }
        if let buttonString = self.buttonString {
            yellowButton.setTitle(buttonString, for: .normal)
        }
    }

    @IBAction func touchGreyButton(_ sender: UIButton) {
        self.popUpActionDelegate?.touchGreyButton(button: sender)
    }
    
    @IBAction func touchYellowButton(_ sender: UIButton) {
        self.popUpActionDelegate?.touchYellowButton(button: sender)
    }
    
    @IBAction func touchCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // case functions
    private func initCase(usage: PopUpUsage) {
        switch usage {
        case .noButton:
            self.initNoButton()
        case .twoButtonNoImage:
            self.initTwoButtonNoImage()
        case .twoButtonWithImage:
            self.initTwoButtonWithImage()
        }
    }
    
    private func initNoButton() {
        // UI
        popUpImageView.removeFromSuperview()
        buttonStackView.removeFromSuperview()
        
        // constraint
        descriptionToBottomConstraint.isActive = true
        descriptionToBottomConstraint.constant = 48
        titleToDescriptionConstraint.constant = 28
   }
    
    private func initTwoButtonNoImage() {
        // UI
        popUpImageView.removeFromSuperview()
        closeButton.removeFromSuperview()
        
        // constraint
        descriptionToBottomConstraint.isActive = false
        descriptionToStackViewConstraint.isActive = true
        descriptionToStackViewConstraint.constant = 27
        titleToDescriptionConstraint.constant = 14
    }
    
    private func initTwoButtonWithImage() {
        // UI
        closeButton.removeFromSuperview()
        
        // constraint
        descriptionToBottomConstraint.isActive = false
        descriptionToStackViewConstraint.isActive = false
        titleToDescriptionConstraint.constant = 32
    }
    
    // set functions
    func setText(title: String, description: String, buttonTitle: String = "변경") {
        titleString = title
        descriptionString = description
        buttonString = buttonTitle
    }
}
