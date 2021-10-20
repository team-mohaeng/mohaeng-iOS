//
//  Reward.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/18.
//

import UIKit

import Lottie

enum Reward {
    case challenge
    case course
    case levelUp
    case curiosity
    case writing
    
    func getButtonText() -> String {
        switch self {
        case .challenge, .course, .levelUp, .curiosity:
            return "계속하기"
        case .writing:
            return "확인"
        }
    }
    
    func getTitleText(level: Int? = nil) -> String {
        switch self {
        case .challenge:
            return ""
//                "오늘의 챌린지 성공!"
        case .course:
            return ""
//            return "코스를 완료했어!"
        case .levelUp:
            guard let level = level else { return ""}
            return """
                Lv. \(String(describing: level)) 달성!
                새로운 스타일이 생겼어
                """
        case .curiosity:
            return """
                오늘 하루는 어땠니,
                너의 안부가 궁금해
                """
        case .writing:
            return "오늘의 안부 작성 완료"
        }
    }
    
    func setGraphicView(view: UIView, styleCard: String? = nil, rewardCard: String? = nil) {
        switch self {
        case .challenge:
            let animationView = AnimationView(name: "awards_congrats").then {
                $0.frame = view.bounds
                $0.contentMode = .scaleAspectFill
            }
            
            let imageView = UIImageView().then {
                $0.image = Const.Image.grpChallengeCompletion
                $0.contentMode = .scaleAspectFit
            }
            
            view.addSubviews(imageView, animationView)
            animationView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            imageView.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.width.equalTo(260)
                $0.height.equalTo(199)
            }
            animationView.play()
            animationView.loopMode = .loop

        case .course:
            let animationView = AnimationView(name: "awards_crs_sok2").then {
                $0.center = view.center
                $0.contentMode = .scaleAspectFill
            }
            view.addSubviews(animationView)
            animationView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            animationView.play()
            animationView.loopMode = .loop
            
        case .levelUp:
            guard let styleCard = styleCard else {return}
            let imageView = UIImageView().then {
                $0.contentMode = .scaleAspectFit
            }
            imageView.updateServerImage(styleCard)
            
            let backgroundImageView = UIImageView().then {
                $0.contentMode = .scaleAspectFit
                $0.image = Const.Image.styleCardBg
            }
            backgroundImageView.addSubviews(imageView)
            view.addSubviews(backgroundImageView)
            imageView.snp.makeConstraints {
                $0.trailing.equalToSuperview()
                $0.leading.equalToSuperview().inset(55)
                $0.bottom.top.equalToSuperview().inset(20)
            }
            
            backgroundImageView.snp.makeConstraints {
                $0.width.equalTo(189)
                $0.height.equalTo(259)
                $0.centerX.bottom.equalToSuperview()
            }
           
        case .curiosity:
            let imageView = UIImageView().then {
                $0.image = Const.Image.grpCuriousity
                $0.contentMode = .scaleAspectFit
            }
            view.addSubviews(imageView)
            imageView.snp.makeConstraints {
                $0.width.equalTo(260)
                $0.height.equalTo(212)
                $0.bottom.equalToSuperview().inset(25)
                $0.centerX.equalToSuperview()
            }
            
        case .writing:
            let imageView = UIImageView().then {
                $0.image = Const.Image.grpWritingCompletion
                $0.contentMode = .scaleAspectFit
            }
            view.addSubviews(imageView)
            imageView.snp.makeConstraints {
                $0.width.equalTo(260)
                $0.height.equalTo(214)
                $0.bottom.equalToSuperview().inset(25)
                $0.centerX.equalToSuperview()
            }
        }
        
    }
    
    func setDescriptionView(view: UIView, happy: Int? = nil) {
        switch self {
        case .challenge, .course, .writing:
            guard let happy = happy else {return}
            let animationView = AnimationView(name: "awards_congrats").then {
                $0.frame = view.bounds
                $0.contentMode = .scaleAspectFill
            }
            
            let label = UILabel().then {
                $0.text = "해피지수 \(String(describing: happy)) 획득!"
                $0.numberOfLines = 1
                $0.font = .spoqaHanSansNeo(weight: .bold, size: 18)
                $0.textColor = .Yellow1
                $0.textAlignment = .center
            }
            
            view.addSubviews(animationView, label)
            [animationView, label].forEach {
                $0.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            }
            
            animationView.play()
            animationView.loopMode = .loop
           
        case .levelUp:
            let label = UILabel().then {
                $0.text = """
                    캐릭터 스타일을 적용해
                    메인화면을 변경해봐!
                    """
                $0.numberOfLines = 0
                $0.font = .spoqaHanSansNeo(weight: .regular, size: 16)
                $0.textColor = .Grey1
                $0.textAlignment = .center
                $0.setLineHeight(lineHeight: 25)
            }
            
            view.addSubviews(label)
            label.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case .curiosity:
            let label = UILabel().then {
                $0.text = """
                    챌린지와 함께한
                    하루 이야기를 한줄로 들려줘
                    """
                $0.numberOfLines = 0
                $0.font = .spoqaHanSansNeo(weight: .regular, size: 16)
                $0.textColor = .Grey1
                $0.textAlignment = .center
                $0.setLineHeight(lineHeight: 25)
            }
            
            view.addSubviews(label)
            label.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
       
        }
    }
    
}
