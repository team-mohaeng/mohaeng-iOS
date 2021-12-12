//
//  hashTagCollectionViewCell.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/09.
//

import UIKit

class HashTagCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var keywordLabel: UILabel!
    
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - fuction
    
    func setData(keyword: String?) {
        keywordLabel.text = keyword
    }
    
    func getIndexPath() -> Int {
        var indexPath = 0
        
        guard let superView = self.superview as? UICollectionView else {
            return -1
        }
        indexPath = superView.indexPath(for: self)!.row
        
        return indexPath
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchRemoveButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("hashTagRemoveButtonClicked"), object: getIndexPath())
    }
}
