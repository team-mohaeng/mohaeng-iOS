//
//  OnBoarding3HeaderView.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/12.
//

import UIKit

import SnapKit
import Then

class OnBoarding3HeaderView: UIView {
    
// MARK: - Properties
    
    public var isDone: Bool = false {
        didSet {
            scrollIconImageView.isHidden = !isDone
            challengeCardView.isDone = isDone
            if isDone {
                label.makeTyping(text: """
                    오늘 챌린지 수행 축하해~

                    화면을 위로 당기면 지금 하고있는
                    코스 진행 상황을 파악할 수 있어
                    """, highlightedText: "코스 진행 상황")
                scrollIconImageView.makeFade()
                scrollIconImageView.makeSpring()
                challengeCardView.isUserInteractionEnabled = false
            } else {
                label.makeTyping(text: """
                    재밌는 챌린지를 골랐네~

                    인증버튼을 눌러서
                    오늘의 챌린지를 완료해봐!
                    """, highlightedText: "인증")
                challengeCardView.isUserInteractionEnabled = true
            }
        }
    }
    
    public var course: AppCourse? {
        didSet {
            challengeCardView.course = course
        }
    }
    
    public var delegate: OnBoardingChallengeCardViewDelegate? {
        didSet {
             challengeCardView.delegate = delegate
        }
    }
    
    private let label = UILabel().then {
        $0.font = .gmarketFont(weight: .medium, size: 16)
        $0.numberOfLines = 0
    }
    
    private let rightCharacterImageView = UIImageView().then {
        $0.image = Const.Image.grpXonboarding4
    }
    
    private let challengeCardView = OnBoardingChallengeCardView().then {
        $0.dropShadow(rounded: 20)
    }
    
    private let scrollIconImageView = UIImageView().then {
        $0.image = Const.Image.iconScroll
        $0.contentMode = .scaleAspectFit
    }
    
// MARK: - View Life Cycle

    public init() {
        super.init(frame: CGRect.zero)
        initView()
        setLayout()
        addAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Functions
        
    private func initView() {
        backgroundColor = .White
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        addSubviews(label, rightCharacterImageView, challengeCardView, scrollIconImageView)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.current.hasNotch ? 44 : 32)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        rightCharacterImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(challengeCardView.snp.top)
            $0.width.equalTo(UIDevice.current.hasNotch ? 160 : 140)
            $0.height.equalTo(UIDevice.current.hasNotch ? 120 : 105)
        }
        
        challengeCardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(UIDevice.current.hasNotch ? 426 : 360)
            $0.bottom.equalToSuperview().offset(UIDevice.current.hasNotch ? -100 : -70)
        }
        
        scrollIconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(19)
            $0.width.equalTo(31)
            $0.bottom.equalToSuperview().offset(UIDevice.current.hasNotch ? -40 : -20)
        }
    }
    
    private func addAnimation() {
        [rightCharacterImageView, challengeCardView].forEach { $0.makeMoveUpWithFade()}
    }
}
