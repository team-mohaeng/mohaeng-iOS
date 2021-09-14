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
        
        dateLabel.text = "\(make2DigitYear(year: year))년 \(currentMonth)월 소확행"
    }
    
    @objc private func setData(notification: NSNotification) {
        if let date = notification.object as? Array<String> {
            let year = make2DigitYear(year: date[0])
            let month = date[1]
            
            dateLabel.text = "\(year)년 \(month)월 소확행"
        }
    }
    
    private func make2DigitYear(year: String) -> Substring {
        let startIndex: String.Index = year.index(year.startIndex, offsetBy: 2)
        let doubleDigitYear = year[startIndex...]
        
        return doubleDigitYear
    }
    
    // MARK: - IBAction
    @IBAction func touchCalendarButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("calendarButtonClicked"), object: nil)
    }
}
