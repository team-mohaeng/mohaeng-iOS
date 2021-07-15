//
//  MyDrawerCollectionReusableView.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/07.
//

import UIKit

class MyDrawerCollectionReusableView: UICollectionReusableView {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calendarButton: UIButton!
    
    // MARK: - Properties
    var currentDate: AppDate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addObserver()
        setInitialDate()
    }
    
    // MARK: - function
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(setData), name: NSNotification.Name("datePickerSelected"), object: nil)
    }
    
    private func setInitialDate() {
        currentDate = AppDate()
        
        guard let year = currentDate?.getYearToString() else { return }
        guard let currentMonth = currentDate?.getMonthToString() else { return }
        
        let startIndex: String.Index = year.index(year.startIndex, offsetBy: 2)
        let currentYear = year[startIndex...]
        
        dateLabel.text = "\(currentYear)년 \(currentMonth)월 소확행"
    }
    
    @objc private func setData(notification: NSNotification) {
        if let date = notification.object as? AppDate {
            guard let year = currentDate?.getYearToString() else { return }
            let startIndex: String.Index = year.index(year.startIndex, offsetBy: 2)
            let currentYear = year[startIndex...]
            dateLabel.text = "\(currentYear)년 \(date.getMonth())월 소확행"
        }
    }
    
    // MARK: - IBAction
    @IBAction func touchCalendarButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("calendarButtonClicked"), object: nil)
    }
}
