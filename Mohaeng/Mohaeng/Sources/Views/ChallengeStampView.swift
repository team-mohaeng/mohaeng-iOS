//
//  ChallengeStampView.swift
//  Journey
//
//  Created by 초이 on 2021/08/20.
//

import UIKit

class ChallengeStampView: UIView {

    // MARK: - Properties
    weak var challengePopUpProtocol: ChallengePopUpProtocol?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var characterLineView: UIView!
    @IBOutlet weak var dayLabelView: UIView!
    @IBOutlet weak var stampBgView: UIView!
    @IBOutlet weak var stampImageView: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        initViewRounding()
        addTapGesture()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        characterLineView.makeRounded(radius: 20)
        dayLabelView.makeRounded(radius: dayLabelView.frame.height / 2)
        stampBgView.makeRounded(radius: 20)
        
    }
    
    private func addTapGesture() {
        stampImageView.isUserInteractionEnabled = true
        let stampGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchStamp(_:)))
        stampImageView.addGestureRecognizer(stampGesture)
    }
    
    // MARK: - @IBAction Functions

    @objc func touchStamp(_ gesture: UITapGestureRecognizer) {
        self.challengePopUpProtocol?.touchStampButton(gesture)
    }
    
    @IBAction func touchHelp(_ sender: UIButton) {
        self.challengePopUpProtocol?.touchHelpButton(sender)
    }
}
