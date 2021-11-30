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
    
    // MARK: - Properties
    
    private var postId = 0
    private var indexPath = 0
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Functions
    
    func setPostId(postId: Int) {
        self.postId = postId
    }
    
    func setCurrentIndex(index: Int) {
        indexPath = index
    }
    
    @IBAction func touchEmojiButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("PlusButtonDidTap"),
                                        object: [postId, indexPath],
                                        userInfo: nil)
    }

}
