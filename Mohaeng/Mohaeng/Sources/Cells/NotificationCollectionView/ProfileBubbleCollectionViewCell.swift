//
//  ProfileBubbleCollectionViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/08/30.
//

import UIKit

class ProfileBubbleCollectionViewCell: UICollectionViewCell {    
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var profileBgView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bubbleBgView: UIView!
    @IBOutlet weak var bubbleTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        profileBgView.makeRounded(radius: 12)
        bubbleBgView.makeRounded(radius: 10)
    }
    
    func setCell(msg: Message) {
        bubbleTextLabel.text = msg.message[0]
        dateLabel.text = msg.date
        
        if !msg.isNew {
            bubbleTextLabel.textColor = UIColor.GreyTextPush2
        } else {
            bubbleTextLabel.textColor = UIColor.BlackText
        }
    }

}
