//
//  AnimationPopUpViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/13.
//

import UIKit

class AnimationPopUpViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var animationImageView: UIView!
    @IBOutlet weak var pinkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    var popUpActionDelegate: AnimationPopUpDelegate?
    var titleLabelText = ""
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewRounding()
        titleLabel.text = titleLabelText
        popUpView.alpha = 0.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        moveImageToTop()
    }
    
    // MARK: - @IBAction Functions
    
    @IBAction func touchPinkButton(_ sender: UIButton) {
        self.popUpActionDelegate?.touchPinkButtonInAnimation(button: sender)
    }
    
    @IBAction func touchWhiteButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        popUpView.makeRounded(radius: 10)
        pinkButton.makeRounded(radius: pinkButton.frame.height / 2)
    }
    
    private func moveImageToTop() {
        UIView.animate(withDuration: 1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn) {
            
            let originFrame = self.animationImageView.frame
            let offset = self.popUpView.frame.origin.y - 50
            
            self.animationImageView.frame = CGRect(x: originFrame.origin.x, y: offset, width: originFrame.width, height: originFrame.height)
            
        } completion: { _ in
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                
                self.popUpView.alpha = 1.0
                
            }, completion: nil)
        }
    }
}
