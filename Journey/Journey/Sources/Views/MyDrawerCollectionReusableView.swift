//
//  MyDrawerCollectionReusableView.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/07.
//

import UIKit

class MyDrawerCollectionReusableView: UICollectionReusableView {

    // MARK: - IBOutlet Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addObserver()
    }
    
    // MARK: - function
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(setData), name: NSNotification.Name("datePickerSelected"), object: nil)
    }
    
    @objc private func setData(notification: NSNotification) {
        if let date = notification.object as? String {
            dateLabel.text = date + " 소확행"
        }
    }
    
    // MARK: - IBAction
    @IBAction func touchCalendarButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("calendarButtonClicked"), object: nil)
    }
}
