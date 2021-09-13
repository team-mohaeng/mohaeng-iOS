//
//  UndoneCourseCollectionViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import UIKit

class CourseLibraryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var courseViewModel: CourseViewModel! {
        didSet {
            titleLabel.text = courseViewModel.course.title
            coursePropertyLabel.text = " \(courseViewModel.course.totalDays)일 코스"
            descriptionTextView.text = courseViewModel.course.courseDescription
            setProperty(by: courseViewModel.course.property)
        }
    }
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var startCourseView: UIView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var courseDescriptionView: UIView!
    @IBOutlet weak var coursePropertyLabel: UILabel!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
        initTextView()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        cellBgView.makeRounded(radius: 10)
        courseDescriptionView.makeRounded(radius: courseDescriptionView.frame.height / 2)
    }
    
    private func initTextView() {
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        descriptionTextView.textContainer.maximumNumberOfLines = 0
    }
    
    func setButtonTitle(doingCourse: Bool) {
        if doingCourse {
            startLabel.text = "코스 변경하기"
        } else {
            startLabel.text = "코스 시작하기"
        }
    }
    
    // set property functions
    
    func setProperty(by property: Int) {
        guard let course = AppCourse(rawValue: property) else { return }
        
        coursePropertyLabel.text = course.getKorean() + coursePropertyLabel.text!
        cellBgView.backgroundColor = course.getLightColor()
        courseDescriptionView.backgroundColor = course.getBubbleColor()
        startCourseView.backgroundColor = course.getDarkColor()
        propertyImageView.image = course.getLibraryImage()
    }

}
