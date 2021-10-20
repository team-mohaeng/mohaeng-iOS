//
//  CourseHistoryCollectionViewCell.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/12.
//

import UIKit

class CourseHistoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    weak var coursePopUpProtocol: CoursePopUpProtocol?
    var courseId: Int?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var courseLabelBgView: UIView!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var successDateLabel: UILabel!
    @IBOutlet weak var redoButton: UIButton!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        cellBgView.makeRounded(radius: 25)
        redoButton.makeRounded(radius: redoButton.frame.height / 2)
    }
    
    func setCell(course: CourseHistory) {
        
        self.courseId = course.id
        
        if let appCourse = AppCourse(rawValue: course.property) {
            
            cellBgView.backgroundColor = appCourse.getLightColor()
            courseImageView.image = appCourse.getBigImage()
            courseLabelBgView.backgroundColor = .clear
            courseLabelBgView.makeRoundedWithBorder(radius: courseLabelBgView.frame.height / 2, color: appCourse.getDarkColor().cgColor)
            courseLabel.textColor = appCourse.getDarkColor()
            courseLabel.text = "\(appCourse.getKorean()) \(course.totalDays)일 코스"
            redoButton.backgroundColor = appCourse.getDarkColor()
            
        }
        
        courseNameLabel.text = course.title
        successDateLabel.text = "\(course.year)년 \(course.month)월 \(course.date)일 성공"
    }
    
    // MARK: - @IBAction Functions

    @IBAction func touchRedoButton(_ sender: UIButton) {
        
        if let courseId = courseId {
            self.coursePopUpProtocol?.touchStartNewCourseButton(sender, courseId: courseId)
        }
        
    }
}
