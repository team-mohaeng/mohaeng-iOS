//
//  CourseHistoryCollectionViewCell.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/12.
//

import UIKit

class CourseHistoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var courseLabelBgView: UIView!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var successDateLabel: UILabel!
    @IBOutlet weak var redoButton: UIButton!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        cellBgView.makeRounded(radius: 25)
        redoButton.makeRounded(radius: redoButton.frame.height / 2)
    }
    
    func setCell() {
        
    }
    
    // MARK: - @IBAction Functions

    @IBAction func touchRedoButton(_ sender: Any) {
        // TODO: - 포기 팝업
    }
}
