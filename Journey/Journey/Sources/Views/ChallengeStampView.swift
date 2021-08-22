//
//  ChallengeStampView.swift
//  Journey
//
//  Created by 초이 on 2021/08/20.
//

import UIKit

class ChallengeStampView: UIView {

    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var characterLineView: UIView!
    @IBOutlet weak var dayLabelView: UIView!
    @IBOutlet weak var stampBgView: UIView!
    
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
    
    // MARK: - @IBAction Functions

}
