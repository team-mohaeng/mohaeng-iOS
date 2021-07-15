//
//  UndoneCourseCollectionViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import UIKit

class UndoneCourseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var courseViewModel: CourseViewModel! {
        didSet {
            titleLabel.text = courseViewModel.course.title
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
        cellBgView.backgroundColor = UIColor.typeH
        courseDescriptionView.backgroundColor = UIColor.typeHD
        startCourseView.backgroundColor = UIColor.typeHD
        propertyImageView.image = Const.Image.typeHwithColor
    }
    
    func setProperty1() {
        coursePropertyLabel.text = "기억"
        cellBgView.backgroundColor = UIColor.typeM
        courseDescriptionView.backgroundColor = UIColor.typeMD
        startCourseView.backgroundColor = UIColor.typeMD
        propertyImageView.image = Const.Image.typeMwithColor
    }
    
    func setProperty2() {
        coursePropertyLabel.text = "관찰"
        cellBgView.backgroundColor = UIColor.typeS
        courseDescriptionView.backgroundColor = UIColor.typeSD
        startCourseView.backgroundColor = UIColor.typeSD
        propertyImageView.image = Const.Image.typeSwithColor
    }
    
    func setProperty3() {
        coursePropertyLabel.text = "도전"
        cellBgView.backgroundColor = UIColor.typeC
        courseDescriptionView.backgroundColor = UIColor.typeCD
        startCourseView.backgroundColor = UIColor.typeCD
        propertyImageView.image = Const.Image.typeCwithColor
    }

}
