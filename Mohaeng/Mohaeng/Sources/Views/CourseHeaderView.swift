//
//  CourseHeaderView.swift
//  Journey
//
//  Created by 초이 on 2021/08/25.
//

import UIKit

class CourseHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerBgView: UIView!
    @IBOutlet weak var dayBgView: UIView!
    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var courseNameLabel: UILabel!
    
    override func awakeFromNib() {
        initViewRounding()
    }
    
    private func initViewRounding() {
        dayBgView.makeRounded(radius: dayBgView.frame.height / 2)
    }
    
    func setProperty(by property: Int) {
        if let course = AppCourse(rawValue: property) {
            propertyImageView.image = course.getBigImage()
            dayBgView.backgroundColor = course.getDarkColor()
        }
    }
    
    func setCourseName(name: String) {
        courseNameLabel.text = name
    }

}
