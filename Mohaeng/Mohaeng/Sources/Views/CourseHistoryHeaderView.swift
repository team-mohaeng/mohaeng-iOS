//
//  CourseHistoryHeaderView.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/12.
//

import UIKit

class CourseHistoryHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var headerBgView: UIView!
    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var dayBgView: UIView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
    }
    
    // MARK: - Functions
    
    func setProperty(by property: Int, day: Int) {
        if let course = AppCourse(rawValue: property) {
            propertyImageView.image = course.getBigImage()
            dayBgView.backgroundColor = .clear
            dayBgView.makeRoundedWithBorder(radius: dayBgView.frame.height / 2, color: course.getDarkColor().cgColor)
            dayLabel.text = "\(course.getKorean()) \(day)일 코스"
            dayLabel.textColor = course.getDarkColor()
        }
    }
    
    func setCourseName(name: String) {
        courseNameLabel.text = name
    }
    
}
