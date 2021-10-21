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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    
    func initSelectedState() {
        if isSelected {
            selectCell()
        } else {
            deselectCell()
        }
    }
    
    func setLabel(title: String) {
        categoryLabel.text = title
    }
    
    func selectCell() {
        self.isSelected = true
        categoryLabel.textColor = .Black
    }
    
    func deselectCell() {
        self.isSelected = false
        categoryLabel.textColor = .Grey4
    }
}
