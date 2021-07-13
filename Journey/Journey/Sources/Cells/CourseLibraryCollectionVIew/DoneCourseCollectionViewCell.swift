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
            courseDaysLabel.text = "\(courseViewModel.course.totalDays)"
            descriptionTextView.text = courseViewModel.course.courseDescription
            
            // TODO: - property 따라 이미지, 배경색 변경
        }
    }
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var courseDaysLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var startCourseView: UIView!
    @IBOutlet weak var startLabel: UILabel!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
        initTextView()
        addActionToStartCourseView()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        cellBgView.makeRounded(radius: 14)
    }
    
    private func initTextView() {
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func addActionToStartCourseView() {
        let startViewGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchStartCourseView(_:)))
        startCourseView.addGestureRecognizer(startViewGesture)
    }
    
    @objc func touchStartCourseView(_ gesture: UITapGestureRecognizer) {
          // 동작
    }
    
    func setButtonTitle(doingCourse: Bool) {
        if doingCourse {
            startLabel.text = "코스 변경하기"
        } else {
            startLabel.text = "코스 시작하기"
        }
    }

}
