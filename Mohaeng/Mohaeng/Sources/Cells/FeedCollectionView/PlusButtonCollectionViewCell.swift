//
//  PlusButtonCollectionViewCell.swift
//  Journey
//
//  Created by 윤예지 on 2021/09/10.
//

import UIKit

class PlusButtonCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var plusButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Functions
    
    @IBAction func touchEmojiButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("PlusButtonDidTap"),
                                        object: nil,
                                        userInfo: nil)
    }

}
