//
//  CourseCategoryCollectionViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/09/10.
//

import UIKit

class CourseCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Functions
    
    func setLabel(title: String) {
        categoryLabel.text = title
    }
}
