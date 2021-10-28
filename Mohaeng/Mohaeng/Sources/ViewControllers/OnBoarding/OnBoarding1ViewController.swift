//
//  OnBoarding1ViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/10.
//

import UIKit

import SnapKit
import Then

class OnBoarding1ViewController: UIViewController {
    
    var smallMessageBoxImageView = UIImageView().then {
        $0.image = Const.Image.messageBoxSmall
        
        let label = UILabel().then {
            $0.text = "야~ 모행?!"
            $0.font = .gmarketFont(weight: .medium, size: 28)
        }
        
        $0.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }
    }
    
    let largeMessageBoxImageView = UIImageView().then {
        $0.image = Const.Image.messageBoxLarge
        
        let label = UILabel().then {
            $0.text = """
                안녕! 만나서 방가워.
                내 집착을 견딜 준비가 되어있어?
                
                나와 함께 재미있는 챌린지를 수행하며 하루 행복에 더 가까워지길 바라!
                """
            $0.font = .gmarketFont(weight: .medium, size: 16)
            $0.numberOfLines = 0
            $0.setLineHeight(lineHeight: 22)
        }
        
        $0.addSubview(label)
        label.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(37)
        }
    }
    
    let leftCharacterImageView = UIImageView().then {
        $0.image = Const.Image.grpXonboarding1
    }
    
    let rightCharacterImageView = UIImageView().then {
        $0.image = Const.Image.grpXonboarding2
    }
    
    let startButton = UIButton(type: .system).then {
        $0.setBackgroundColor(.Yellow3, for: .normal)
        $0.setTitle("새롭게 시작하기", for: .normal)
        $0.setTitleColor(.White, for: .normal)
        $0.titleLabel?.font = .spoqaHanSansNeo(weight: .bold, size: 16)
        $0.makeRounded(radius: 25)
    }
    
    let loginButton = UIButton().then {
        $0.setTitle("이미 계정이 있어! (로그인하기)", for: .normal)
        $0.setTitleColor(.Black, for: .normal)
        $0.titleLabel?.font = .spoqaHanSansNeo(weight: .regular, size: 10)
        guard let text = $0.titleLabel?.text else { return }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        $0.titleLabel?.attributedText = attributedText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setLayout()
        setTargets()
        addAnimation()
    }
    
    private func setNavigationBar() {
        self.navigationController?.hideNavigationBar()
    }
    
    private func setTargets() {
        [startButton, loginButton].forEach { $0.addTarget(self, action: #selector(touchButton(_:)), for: .touchUpInside) }
    }
    
    private func addAnimation() {
        [loginButton, startButton].forEach { $0.makeFade()}
        [smallMessageBoxImageView, largeMessageBoxImageView].forEach { $0.makeMoveUpWithFade()}
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        view.addSubviews(smallMessageBoxImageView, largeMessageBoxImageView, leftCharacterImageView, rightCharacterImageView, startButton, loginButton)
    }
    
    private func setConstraints() {
        smallMessageBoxImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(UIDevice.current.hasNotch ? 44 : 32)
            $0.leading.equalToSuperview().inset(32)
            $0.width.equalTo(170)
            $0.height.equalTo(73.5)
        }
        
        largeMessageBoxImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(136)
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        
        leftCharacterImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(125)
            $0.height.equalTo(220)
            $0.top.equalTo(largeMessageBoxImageView.snp.bottom).offset(79)
        }
        
        rightCharacterImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(largeMessageBoxImageView.snp.bottom).offset(20)
            $0.width.equalTo(180)
            $0.height.equalTo(300)
        }
        
        startButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(startButton.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(193)
            $0.height.equalTo(24)
        }
    }

}

extension OnBoarding1ViewController {
    @objc
    private func touchButton(_ sender: UIButton) {
        switch sender {
        case startButton:
            self.navigationController?.pushViewController(OnBoarding2ViewController(), animated: true)
        case loginButton:
            presentLoginViewController()
        default:
            break
        }
        
    }
    
    private func presentLoginViewController() {
        let loginStoryboard = UIStoryboard(name: Const.Storyboard.Name.login, bundle: nil)
        let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.login)
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}
