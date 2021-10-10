//
//  ChallengeStampView.swift
//  Journey
//
//  Created by 초이 on 2021/08/20.
//

import UIKit

class ChallengeStampView: UIView {

    // MARK: - Properties
    var askPopUp: PopUpViewController = PopUpViewController()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var characterLineView: UIView!
    @IBOutlet weak var dayLabelView: UIView!
    @IBOutlet weak var stampBgView: UIView!
    @IBOutlet weak var stampImageView: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        characterLineView.makeRounded(radius: 20)
        dayLabelView.makeRounded(radius: dayLabelView.frame.height / 2)
        stampBgView.makeRounded(radius: 20)
        
    }
    
    private func addTapGesture() {
        let stampGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchStamp(_:)))
        stampImageView.addGestureRecognizer(stampGesture)
    }
    
    // MARK: - @IBAction Functions

    @objc func touchStamp(_ gesture: UITapGestureRecognizer) {
//        askPopUp = PopUpViewController(nibName: Const.Xib.Name.popUp, bundle: nil)
//        askPopUp.modalPresentationStyle = .overCurrentContext
//        askPopUp.modalTransitionStyle = .crossDissolve
//        askPopUp.popUpUsage = .noButton
//        askPopUp.popUpActionDelegate = self
//        tabBarController?.present(askPopUp, animated: true, completion: nil)
    }
}
