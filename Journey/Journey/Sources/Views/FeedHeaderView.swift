//
//  FeedHeaderView.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/03.
//

import UIKit

class FeedHeaderView: UIView {

    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var writeFeedButton: UIButton!
    @IBOutlet weak var myDrawerButton: UIButton!
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
       super.awakeFromNib()
        initAttributes()
    }
    
    // MARK: - function
    
    private func initAttributes() {
        writeFeedButton.makeRounded(radius: writeFeedButton.frame.height / 2)
    }
    
    // MARK: - IBAction
    
    @IBAction func touchMyDrawerButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("myDrawerCilcked"), object: nil)
    }
    
    @IBAction func touchWriteHappinessButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("writeHappinessClicked"), object: nil)
    }
    
}
