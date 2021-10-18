//
//  CharaterColorCollectionViewCell.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/09/23.
//

import UIKit

class CharacterColorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var charaterImageView: UIImageView!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    var hasColor: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
        self.contentView.isUserInteractionEnabled = true
    }

    private func initViewRounding() {
        makeRoundedWithBorder(radius: 4, color: UIColor.white.cgColor, borderWith: 0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        charaterImageView.image = nil
    }
    
    func showSelectedView() {
        makeRoundedWithBorder(radius: 4, color: UIColor.YellowButton2.cgColor)
        selectedImageView.isHidden = false
    }
    
    func showUnselectedView() {
        initViewRounding()
        selectedImageView.isHidden = true
    }
    
    func setLockCharacter(typeId: Int) {
        self.charaterImageView.image = AppCharacter(rawValue: typeId)?.getCardLockImage()
    }
    
    func setUnlockCharacter(image: String) {
        self.charaterImageView.updateServerImage(image)
    }
    
    func showNewIndicator() {
        newImageView.isHidden = false
    }
    
    func hideNewIndicator() {
        newImageView.isHidden = true
    }
    
}
