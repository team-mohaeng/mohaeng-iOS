//
//  CharaterTypeCollectionViewCell.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/09/23.
//

import UIKit

class CharacterTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var charaterImageView: UIImageView!
    @IBOutlet weak var selectIndicatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeSelectedViewRounded()
    }
    
    func makeSelectedViewRounded() {
        selectIndicatorView.makeRounded(radius: selectIndicatorView.bounds.height / 2)
    }
    
    func showSelectView() {
        selectIndicatorView.isHidden = false
    }
    
    func hideSelectView() {
        selectIndicatorView.isHidden = true
    }

}
