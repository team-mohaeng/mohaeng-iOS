//
//  OnBoarding2TableViewCell.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/12.
//

import UIKit

class OnBoarding2TableViewCell: UITableViewCell {
    
    static let identifier = "OnBoarding2TableViewCell"
    
    var course: AppCourse? {
        didSet {
            guard let course = course else {return}
            courseTitleLabel.text = course.getKorean() + " 코스"
            courseDescriptionLabel.text = course.getOnBoardingDescription()
            courseImageView.image = course.getLibraryImage()
            cardView.backgroundColor = course.getLightColor()
        }
    }
    
    private let cardView = UIView().then {
        $0.makeRounded(radius: 10)
    }
    
    private let courseTitleLabel = UILabel().then {
        $0.font = .gmarketFont(weight: .medium, size: 20)
        $0.textColor = .Black
    }
    
    private let courseDescriptionLabel = UILabel().then {
        $0.font = .spoqaHanSansNeo(weight: .medium, size: 12)
        $0.textColor = .Black
    }
    
    private let vStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
    }
    
    private let courseImageView = UIImageView().then {
        $0.alpha = 0.5
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initTableViewCell()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        if selected {
            cardView.alpha = 0.3
        }
    }
    
    private func initTableViewCell() {
        backgroundColor = .White
        contentView.backgroundColor = .White
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        contentView.addSubviews(cardView)
        cardView.addSubviews(vStackView, courseImageView)
        vStackView.addArrangedSubview(courseTitleLabel)
        vStackView.addArrangedSubview(courseDescriptionLabel)
    }
    
    private func setConstraints() {
        cardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(104)
            $0.top.equalToSuperview()
        }
        
        vStackView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview().inset(25)
        }
        
        courseImageView.snp.makeConstraints {
            $0.height.width.equalTo(80)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }

}
