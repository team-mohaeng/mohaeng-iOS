//
//  OnBoarding5ViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/12.
//

import UIKit

import Lottie

class OnBoarding5ViewController: UIViewController {
    
    private lazy var animationView = AnimationView(name: "onboardingcard").then {
        $0.contentMode = .scaleAspectFill
        $0.play()
        $0.loopMode = .loop
    }
    
    private let label = UILabel().then {
        $0.font = .gmarketFont(weight: .medium, size: 18)
        $0.numberOfLines = 0
        $0.text = """
        재미있는 챌린지들을 수행해서
        캐릭터들의 레벨을 쌓고
        모행이들의 다양한 모습을 찾아보자.
        """
        $0.setLineHeight(lineHeight: 30)
        $0.textAlignment = .center
    }
    
    private lazy var startButton = UIButton(type: .system).then {
        $0.setBackgroundColor(.Yellow3, for: .normal)
        $0.setTitle("모행과 행복을 향한 챌린지 시작하기", for: .normal)
        $0.setTitleColor(.White, for: .normal)
        $0.titleLabel?.font = .spoqaHanSansNeo(weight: .bold, size: 16)
        $0.makeRounded(radius: 25)
        $0.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
    }
    
// MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        setLayout()
    }
    
    private func render() {
        view.backgroundColor = .White
    }
    
}

// MARK: - @objc Function

extension OnBoarding5ViewController {
    @objc
    private func touchButton(_ sender: UIButton) {
        presentLoginViewController()
    }
    
    private func presentLoginViewController() {
        let loginStoryboard = UIStoryboard(name: Const.Storyboard.Name.login, bundle: nil)
        let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.login)
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - Layouts

extension OnBoarding5ViewController {
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        view.addSubviews(startButton, animationView, label)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(120)
        }
        
        startButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        animationView.snp.makeConstraints {
            $0.bottom.equalTo(startButton.snp.top)
            $0.width.equalTo(360)
            $0.height.equalTo(300)
            $0.centerX.equalToSuperview()
        }
    }
}
