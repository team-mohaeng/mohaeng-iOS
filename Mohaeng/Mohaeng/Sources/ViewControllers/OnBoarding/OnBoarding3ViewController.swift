//
//  OnBoarding3ViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/10.
//

import UIKit

import SnapKit
import Then

class OnBoarding3ViewController: UIViewController {
    
    public var course: AppCourse? {
        didSet {
            challengeCardView.course = course
        }
    }
    
    private let label = UILabel().then {
        $0.setTyping(text: "재밌는 챌린지를 골랐네~\n\n간단하게 수행한 다음,동그란 버튼을 눌러\n오늘의 챌린지를 인증해봐!", highlightedText: "인증")
        $0.font = .gmarketFont(weight: .medium, size: 16)
        $0.numberOfLines = 0
    }
    
    private let rightCharacterImageView = UIImageView().then {
        $0.image = Const.Image.grpXonboarding4
    }
    
    private let challengeCardView = OnBoardingChallengeCardView().then {
        $0.dropShadow(rounded: 20)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        iniViewController()
        setLayout()
        addAnimation()
    }
    
    private func iniViewController() {
        view.backgroundColor = .White
        challengeCardView.delegate = self
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        view.addSubviews(label, rightCharacterImageView, challengeCardView)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        rightCharacterImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(challengeCardView.snp.top)
            $0.width.equalTo(160)
            $0.height.equalTo(120)
        }
        
        challengeCardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(426)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
    }
    
    private func addAnimation() {
        [rightCharacterImageView, challengeCardView].forEach { $0.animateBottomToTopWithOpacity()}
    }

}

extension OnBoarding3ViewController: OnBoardingChallengeCardViewDelegate {
    func touchChallengeImageView() {
        // 팝업
    }
}
