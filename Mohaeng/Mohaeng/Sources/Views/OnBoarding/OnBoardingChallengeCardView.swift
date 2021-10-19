//
//  OnBoardingChallengeCardView.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/10.
//

import UIKit

import SnapKit
import Then

// MARK: - OnBoardingChallengeCardViewDelegate

protocol OnBoardingChallengeCardViewDelegate: AnyObject {
    func touchChallengeImageView()
}

class OnBoardingChallengeCardView: UIView {

// MARK: - Properties
    weak var delegate: OnBoardingChallengeCardViewDelegate?
    
    public var course: AppCourse? {
        didSet {
            guard let course = course else {return}
            cardTitleLabel.textColor = course.getDarkColor()
            dailyLabelView.backgroundColor = course.getDarkColor()
        }
    }
    
    private let cardTitleLabel = UILabel().then {
        $0.text = "어제 외운 단어로 문장 만들기"
        $0.font = .gmarketFont(weight: .medium, size: 25)
        $0.textAlignment = .center
    }
    
    private let dailyLabelView = UIView().then {
        let label = UILabel().then {
            $0.text = "1일차"
            $0.font = .gmarketFont(weight: .medium, size: 12)
            $0.textColor = .White
            $0.textAlignment = .center
        }
        
        $0.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        $0.makeRounded(radius: 12)
    }
    
    private let challengeImageView = UIImageView().then {
        $0.image = Const.Image.typeCchallenge
        $0.isUserInteractionEnabled = true
        $0.makeSpring()
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = "인증버튼을 눌러봐!"
        $0.font = .gmarketFont(weight: .medium, size: 12)
        $0.textColor = .Grey2
        $0.textAlignment = .center
    }
    
// MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        setLayout()
        addTouchEventToImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Functions
    private func initView() {
        self.makeRounded(radius: 20)
        self.backgroundColor = .todayYellow
        self.isUserInteractionEnabled = true
    }
    
    private func addTouchEventToImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchChallengeImageView(_:)))
        challengeImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        addSubviews(dailyLabelView, cardTitleLabel, challengeImageView, subtitleLabel)
    }
    
    private func setConstraints() {
        dailyLabelView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIDevice.current.hasNotch ? 48 : 36)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(61)
            $0.height.equalTo(24)
        }
        
        cardTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(dailyLabelView.snp.bottom).offset(24)
        }
        
        challengeImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(UIDevice.current.hasNotch ? 92 : 68)
            $0.width.height.equalTo(160)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(challengeImageView.snp.bottom).offset(UIDevice.current.hasNotch ? 40 : 28)
        }
    }

}

// MARK: - @objc Function

extension OnBoardingChallengeCardView {
    @objc
    private func touchChallengeImageView(_ sender: UITapGestureRecognizer) {
        delegate?.touchChallengeImageView()
    }
}
