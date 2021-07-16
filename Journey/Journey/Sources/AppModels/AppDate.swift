//
//  AppDate.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/06.
//

import Foundation

class AppDate {
    
    // MARK: - Properties
    
    private var _date: Date?
    public private(set) var date: Date? {
        get {
            return _date
        }
        set(newDate) {
            _date = newDate
            self.setWeekday()
        }
    }
    private var weekday: AppWeekday?
    private let dateFormatter: DateFormatter?
    
    init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter?.locale = Locale.current
        self.date = Date()
    }
    
    convenience init(year: Int, month: Int) {
        self.init()
        
        let dateComponents = NSDateComponents()
//        dateComponents.day = day
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
//              let day = Int(dateArray[2]),
              year >= 0 && year <= 9999,
              month >= 1 && month <= 12 else {
//              day >= 1 && day <= 31 else {
            return
        }
        
        self.init(year: year, month: month)
    }
    
    convenience init(serverDate: String) {
        self.init()
        
        guard let formattedDate = serverDate.split(separator: "T").first else {
            return
        }
        
        self.init(formattedDate: String(formattedDate), with: "-")
    }
    
    // MARK: - Functions
    
    func getFormattedDate(with separator: String) -> String {
        return self.getDateComponent(with: "yyyy\(separator)MM\(separator)")
    }
    
    func getFormattedDateAndWeekday(with separator: String) -> String {
        let formattedDate = self.getDateComponent(with: "yyyy\(separator)MM\(separator)dd")
        guard let weekday = self.weekday?.toKorean() else { return "000" }
        return "\(formattedDate)\(separator)\(weekday)"
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
    
    func getWeekday() -> AppWeekday {
        guard let weekday = self.weekday else { return AppWeekday.monday }
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
        guard let weekday = AppWeekday.init(rawValue: self.getDateComponent(with: "EEEE")) else { return }
        self.weekday = weekday
    }
}

extension AppDate: Equatable {
    static func == (lhs: AppDate, rhs: AppDate) -> Bool {
        return lhs.getFormattedDate(with: ". ") == rhs.getFormattedDate(with: ". ")
    }
}

enum AppWeekday: String {
    case monday = "Monday", tuesday = "Tuesday", wednesday = "Wednesday", thursday = "Thursday", friday = "Friday", saturday = "Saturday", sunday = "Sunday"
    
    func toKorean() -> String {
        switch self {
        case .monday:
            return "월요일"
        case .tuesday:
            return "화요일"
        case .wednesday:
            return "수요일"
        case .thursday:
            return "목요일"
        case .friday:
            return "금요일"
        case .saturday:
            return "토요일"
        case .sunday:
            return "일요일"
        }
    }
    
    func toSimpleKorean() -> String {
        switch self {
        case .monday:
            return "월"
        case .tuesday:
            return "화"
        case .wednesday:
            return "수"
        case .thursday:
            return "목"
        case .friday:
            return "금"
        case .saturday:
            return "토"
        case .sunday:
            return "일"
        }
    }
}
