//
//  FeedContentsCollectionViewCell.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/03.
//

import UIKit

class FeedContentsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hashTagsLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
