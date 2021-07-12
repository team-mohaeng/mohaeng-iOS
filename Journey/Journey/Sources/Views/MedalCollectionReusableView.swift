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
    @IBOutlet weak var affectionLabel: UILabel!
    @IBOutlet weak var bestContinueLabel: UILabel!
    
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
    
    func setText(affinity: Int, successCount: Int) {
        
        if affinity < 10 {
            affectionLabel.text = "0\(affinity)"
        } else {
            affectionLabel.text = "\(affinity)"
        }
        
        if successCount < 10 {
            bestContinueLabel.text = "0\(successCount)"
        } else {
            bestContinueLabel.text = "\(successCount)"
        }
        
    }
    
}
