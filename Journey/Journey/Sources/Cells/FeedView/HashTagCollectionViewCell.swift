//
//  hashTagCollectionViewCell.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/09.
//

import UIKit

class HashTagCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet Properties
    @IBOutlet weak var keywordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(keyword: String?) {
        keywordLabel.text = keyword
    }
    
}
