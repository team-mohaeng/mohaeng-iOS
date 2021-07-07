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
            courseDaysLabel.text = "\(courseViewModel.course.courseDays)"
            descriptionTextView.text = courseViewModel.course.description
        }
    }
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var courseDaysLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        cellBgView.makeRounded(radius: 14)
    }
    
    func setButtonTitle(doingCourse: Bool) {
        if doingCourse {
            startButton.setTitle("코스 변경하기", for: .normal)
        } else {
            startButton.setTitle("코스 시작하기", for: .normal)
        }
    }

}
