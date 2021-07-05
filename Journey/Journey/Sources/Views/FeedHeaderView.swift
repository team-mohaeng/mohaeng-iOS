//
//  FeedHeaderView.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/03.
//

import UIKit

class FeedHeaderView: UIView {

    @IBOutlet weak var writeFeedButton: UIButton!
    
    override func awakeFromNib() {
       super.awakeFromNib()
        initAttributes()
    }
    
    private func initAttributes() {
        writeFeedButton.makeRounded(radius: writeFeedButton.frame.height / 2)
    }
}
