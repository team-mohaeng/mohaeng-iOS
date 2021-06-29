//
//  FirstDayTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class FirstDayTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var roadView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var propertyImageView: UIView!
    @IBOutlet weak var propertyBgView: UIView!
    @IBOutlet weak var dayCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayLabelBgView: UIView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        propertyBgView.makeRounded(radius: propertyBgView.frame.height / 2)
        dayLabelBgView.makeRounded(radius: dayLabelBgView.frame.height / 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
