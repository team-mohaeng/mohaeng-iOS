//
//  MedalCollectionViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import UIKit

class MedalCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var property: Int = 0
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var propertyImageView: UIImageView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        cellBgView.makeRounded(radius: 10)
        completeView.makeRounded(radius: completeView.frame.height / 2)
    }
    
    func setCell(course: Course) {
        // TODO: - property 이미지 바꿔주기
        dayLabel.text = "\(course.totalDays)일 코스"
        titleLabel.text = course.title
        
        if let lastChallenge = course.challenges.last {
            dateLabel.text = "\(lastChallenge.year).\(lastChallenge.month).\(lastChallenge.day)"
        }
        
        // TODO: - property값 int로 오면 테스팅
        setProperty(by: 3)
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
        cellBgView.backgroundColor = UIColor.typeH
        propertyImageView.image = Const.Image.typeHwithColor
    }
    
    func setProperty1() {
        cellBgView.backgroundColor = UIColor.typeM
        propertyImageView.image = Const.Image.typeMwithColor
    }
    
    func setProperty2() {
        cellBgView.backgroundColor = UIColor.typeS
        propertyImageView.image = Const.Image.typeSwithColor
    }
    
    func setProperty3() {
        cellBgView.backgroundColor = UIColor.typeC
        propertyImageView.image = Const.Image.typeCwithColor
    }
}
