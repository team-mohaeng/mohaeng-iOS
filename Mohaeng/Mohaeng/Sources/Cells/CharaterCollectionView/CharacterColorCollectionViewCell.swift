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
        makeRoundedWithBorder(radius: 4, color: UIColor.systemYellow.cgColor)
        selectedImageView.isHidden = false
    }
    
    func showUnselectedView() {
        initViewRounding()
        selectedImageView.isHidden = true
    }
    
    func setLockCharacter() {
        DispatchQueue.main.async {
            self.charaterImageView.image = Const.Image.lockDuck
        }
    }
    
    func setUnlockCharacter() {
        DispatchQueue.main.async {
            self.charaterImageView.image = Const.Image.unlockDuck
        }
    }
    
    func showNewIndicator() {
        newImageView.isHidden = false
    }
    
    func hideNewIndicator() {
        newImageView.isHidden = true
    }
    
}

