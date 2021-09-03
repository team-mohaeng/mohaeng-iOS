//
//  AppDate.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/06.
//

import Foundation

class AppDate {
    
    // MARK: - Properties
    
    private var date: Date?
    private var weekday: String?
    private let dateFormatter: DateFormatter?
    
    init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter?.locale = Locale(identifier: "ko-KR")
        self.date = Date()
        self.setWeekday()
    }
    
    convenience init(year: Int, month: Int, day: Int) {
        self.init()
        
        let dateComponents = NSDateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        guard let calendar = NSCalendar(calendarIdentifier: .gregorian) else { return }
        self.date = calendar.date(from: dateComponents as DateComponents)
    }
    
    convenience init(formattedDate: String, with separator: String) {
        self.init()
        let dateArray: [String] = formattedDate.components(separatedBy: separator)
        
        guard let year = Int(dateArray[0]),
              let month = Int(dateArray[1]),
              let day = Int(dateArray[2]),
              year >= 0 && year <= 9999,
              month >= 1 && month <= 12,
              day >= 1 && day <= 31 else {
            return
        }
        
        self.init(year: year, month: month, day: day)
    }
    
    // MARK: - Functions
    
    func getFormattedDate(with separator: String) -> String {
        return self.getDateComponent(with: "yyyy\(separator) MM\(separator) dd")
    }
    
    func getDay() -> Int {
        guard let day = Int(self.getDateComponent(with: "dd")) else { return 0 }
        return day
    }
    
    func getMonth() -> Int {
        guard let month = Int(self.getDateComponent(with: "MM")) else { return 0 }
        return month
    }
    
    func getYear() -> Int {
        guard let year = Int(self.getDateComponent(with: "yyyy")) else { return 0 }
        return year
    }
    
    func getYearWithYY() -> Int {
        guard let year = Int(self.getDateComponent(with: "yy")) else { return 0 }
        return year
    }
    
    func getHour() -> Int {
        guard let hour = Int(self.getDateComponent(with: "H")) else { return 0 }
        return hour
    }
    
    func getWeekday() -> String {
        guard let weekday = self.weekday else { return "" }
        return weekday
    }

    func getDayToString() -> String {
        return "\(self.getDay())"
    }
    
    func getMonthToString() -> String {
        return "\(self.getMonth())"
    }
    
    func getYearToString() -> String {
        return "\(self.getYear())"
    }
    
    private func getDateComponent(with format: String) -> String {
        guard let dateFormatter = self.dateFormatter, let safeDate = self.date else { return "0000" }
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: safeDate)
    }
    
    private func setWeekday() {
        let weekday = self.getDateComponent(with: "EE")
        self.weekday = weekday
    }
}
