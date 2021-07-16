//
//  DoneCourseCollectionViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import UIKit

class DoneCourseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var courseViewModel: CourseViewModel! {
        didSet {
            titleLabel.text = courseViewModel.course.title
            coursePropertyLabel.text = "\(courseViewModel.course.property)"
            courseDaysLabel.text = "\(courseViewModel.course.totalDays)일"
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
    @IBOutlet weak var courseDaysLabel: UILabel!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
        initTextView()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        cellBgView.makeRounded(radius: 14)
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
        switch property {
        case Property.health.rawValue:
            setProperty0()
        case Property.memory.rawValue:
            setProperty1()
        case Property.observation.rawValue:
            setProperty2()
        case Property.challenge.rawValue:
            setProperty3()
        default:
            return
        }
    }
    
    // 0: 건강 1: 기억 2: 관찰 3: 도전
    func setProperty0() {
        coursePropertyLabel.text = "건강"
        propertyImageView.image = Const.Image.typeHforLibraryGrey
    }
    
    func setProperty1() {
        coursePropertyLabel.text = "기억"
        propertyImageView.image = Const.Image.typeMforLibraryGrey
    }
    
    func setProperty2() {
        coursePropertyLabel.text = "관찰"
        propertyImageView.image = Const.Image.typeSforLibraryGrey
    }
    
    func setProperty3() {
        coursePropertyLabel.text = "도전"
        propertyImageView.image = Const.Image.typeCforLibraryGrey
    }
}
