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
            
        }
    }
    private let dateFormatter: DateFormatter?
    
    init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter?.locale = Locale.current
        self.date = Date()
    }
    
    convenience init(year: Int, month: Int) {
        self.init()
        
        let dateComponents = NSDateComponents()
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
              year >= 0 && year <= 9999,
              month >= 1 && month <= 12
        else { return }
        
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
    
    func getMonth() -> Int {
        guard let month = Int(self.getDateComponent(with: "MM")) else { return 0 }
        return month
    }
    
    func getYear() -> Int {
        guard let year = Int(self.getDateComponent(with: "yyyy")) else { return 0 }
        return year
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
}

extension AppDate: Equatable {
    static func == (lhs: AppDate, rhs: AppDate) -> Bool {
        return lhs.getFormattedDate(with: ". ") == rhs.getFormattedDate(with: ". ")
    }
}
