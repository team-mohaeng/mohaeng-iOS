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
    @IBOutlet weak var successDateLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
    }
    
    // MARK: - Functions
    
    func setData(by course: TodayChallengeCourse) {
        if let appCourse = AppCourse(rawValue: course.property) {
            propertyImageView.image = appCourse.getBigImage()
            dayBgView.backgroundColor = .clear
            dayBgView.makeRoundedWithBorder(radius: dayBgView.frame.height / 2, color: appCourse.getDarkColor().cgColor)
            dayLabel.text = "\(appCourse.getKorean()) \(course.totalDays)일 코스"
            dayLabel.textColor = appCourse.getDarkColor()
        }
        successDateLabel.text = "\(course.year)년 \(course.month)월 \(course.date)일 성공"
    }
    
    func setCourseName(name: String) {
        courseNameLabel.text = name
    }
    
}
