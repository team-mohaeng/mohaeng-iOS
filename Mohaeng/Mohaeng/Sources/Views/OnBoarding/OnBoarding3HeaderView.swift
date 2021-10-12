//
//  OnBoarding3HeaderView.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/12.
//

import UIKit

class OnBoarding3HeaderView: UIView {
    
    public var isDone: Bool = false {
        didSet {
            scrollIconImageView.isHidden = !isDone
            if isDone {
                if UIDevice.current.hasNotch {
                    label.setTyping(text: "오늘 챌린지 완료 축하해~\n\n화면을 위로 당기면\n지금 하고있는 코스의 진행상황도 파악할 수 있어", highlightedText: "코스의 진행상황")
                } else {
                    label.setTyping(text: "오늘 챌린지 완료 축하해~\n\n화면을 위로 당기면 지금 하고있는 \n코스의 진행상황도 파악할 수 있어", highlightedText: "코스의 진행상황")
                }
                scrollIconImageView.animateWithOpacity()
            } else {
                label.setTyping(text: "재밌는 챌린지를 골랐네~\n\n간단하게 수행한 다음,동그란 버튼을 눌러\n오늘의 챌린지를 인증해봐!", highlightedText: "인증")
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
    
    public init() {
        super.init(frame: CGRect.zero)
        initView()
        setLayout()
        addAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            $0.top.equalToSuperview().inset(44)
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
            $0.bottom.equalToSuperview().offset(-50)
        }
        
        scrollIconImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(19)
            $0.width.equalTo(31)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func addAnimation() {
        [rightCharacterImageView, challengeCardView].forEach { $0.animateBottomToTopWithOpacity()}
    }
}
