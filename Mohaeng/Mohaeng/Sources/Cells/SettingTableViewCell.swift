//
//  SettingTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/07/14.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pushNotiSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        pushNotiSwitch.onTintColor = .Yellow1
        pushNotiSwitch.tintColor = .Yellow1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabel(title: String) {
        titleLabel.text = title
    }
    
    func setRedLabel() {
        titleLabel.tintColor = .red
    }
    
    func setSwitch() {
        pushNotiSwitch.isHidden = false
        pushNotiSwitch.onTintColor = .Yellow1
        pushNotiSwitch.tintColor = .Yellow1
        
        if UIApplication.shared.isRegisteredForRemoteNotifications {
            pushNotiSwitch.isOn = true
        } else {
            pushNotiSwitch.isOn = false
        }
        
        pushNotiSwitch.addTarget(self, action: #selector(changeSwitch(_:)), for: .valueChanged)
    }
    
    @objc private func changeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }

}
