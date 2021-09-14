//
//  SettingTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/07/14.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabel(title: String) {
        titleLabel.text = title
    }

}
