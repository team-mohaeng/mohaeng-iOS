//
//  AppYear.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/11.
//

import Foundation

class AppYear {
    
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
    
    convenience init(year: Int) {
        self.init()
        
        let dateComponents = NSDateComponents()
        dateComponents.year = year
    
    }
    
    convenience init(formattedDate: String, with separator: String) {
        self.init()
        let dateArray: [String] = formattedDate.components(separatedBy: separator)
        
        guard let year = Int(dateArray[0]),
              year >= 0 && year <= 9999
        else { return }
        
        self.init(year: year)
    }
    
    convenience init(serverDate: String) {
        self.init()
        
        guard let formattedDate = serverDate.split(separator: "T").first else {
            return
        }
        
        self.init(formattedDate: String(formattedDate), with: "-")
    }
    
    // MARK: - Functions
    
    func getYear() -> Int {
        guard let year = Int(self.getDateComponent(with: "yyyy")) else { return 0 }
        return year
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
