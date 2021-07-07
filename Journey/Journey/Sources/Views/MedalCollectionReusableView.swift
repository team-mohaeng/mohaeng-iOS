//
//  MedalCollectionReusableView.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import UIKit

class MedalCollectionReusableView: UICollectionReusableView {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var affectionView: UIView!
    @IBOutlet weak var bestContinueView: UIView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        affectionView.makeRounded(radius: 10)
        bestContinueView.makeRounded(radius: 10)
    }
    
}
