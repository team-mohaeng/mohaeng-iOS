//
//  BackgroundCollectionViewCell.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/09/25.
//

import UIKit

class BackgroundCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    func setData(image: UIImage) {
        backgroundImageView.image = image
    }

}
