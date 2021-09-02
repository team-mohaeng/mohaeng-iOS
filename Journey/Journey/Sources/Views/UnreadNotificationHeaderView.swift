//
//  UnreadNotificationHeaderView.swift
//  Journey
//
//  Created by 초이 on 2021/09/02.
//

import UIKit

class UnreadNotificationHeaderView: UICollectionReusableView {

    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var yellowBgView: UIView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        yellowBgView.makeRounded(radius: yellowBgView.frame.height / 2)
    }
    
}
