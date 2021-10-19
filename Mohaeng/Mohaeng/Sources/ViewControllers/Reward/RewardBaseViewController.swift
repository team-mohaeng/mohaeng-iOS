//
//  RewardBaseViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/18.
//

import UIKit

import SnapKit
import Then
import Lottie

class RewardBaseViewController: UIViewController {

// MARK: - Public Properties
    
    public lazy var level: Int = 0
    public lazy var imgURL: String = ""
    public lazy var happy: Int = 0
    
    public var type: Reward? {
        didSet {
            guard let type = type else {return}
           
            /// Reward Title Text
            switch type {
            case .challenge, .course, .curiosity, .writing:
                label.text = type.getTitleText()
            case .levelUp:
                label.text = type.getTitleText(level: level)
            }
            label.setLineHeight(lineHeight: 40)
            
            /// Button Text
            button.setTitle(type.getButtonText(), for: .normal)
            
            /// SubButton isHidden
            switch type {
            case .challenge, .course, .levelUp, .writing:
                subButtonIsHidden = true
            case .curiosity:
                subButtonIsHidden = false
            }
            
            /// Graphic
            switch type {
            case .challenge, .course, .curiosity, .writing:
                type.setGraphicView(view: self.graphicView)
            case .levelUp:
                type.setGraphicView(view: self.graphicView, styleCard: imgURL)
            }
            
            /// Description
            switch type {
            case .challenge, .course, .writing:
                type.setDescriptionView(view: self.descriptionView, happy: happy)
            case .levelUp, .curiosity:
                type.setDescriptionView(view: self.descriptionView)
            }
           
        }
    }
 
// MARK: - Private Properties
    private let button = UIButton(type: .system).then {
        $0.backgroundColor = .YellowButton2
        $0.setTitleColor(.White, for: .normal)
        $0.titleLabel?.font = .spoqaHanSansNeo(weight: .bold, size: 18)
        $0.makeRounded(radius: 10)
    }
    
    private lazy var subButton  = UIButton(type: .system).then {
        $0.setTitleColor(.Yellow3, for: .normal)
        $0.titleLabel?.font = .spoqaHanSansNeo(weight: .medium, size: 18)
        $0.setTitle("나중에", for: .normal)
    }
    
    private let label = UILabel().then {
        $0.font = .gmarketFont(weight: .medium, size: 26)
        $0.textColor = .Black
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private lazy var graphicView = UIView()

    private lazy var descriptionView = UIView()
    
    private var subButtonIsHidden: Bool? {
        didSet {
            guard let isHidden = subButtonIsHidden else {return}
            if !isHidden {
                view.addSubview(subButton)
                subButton.snp.makeConstraints {
                    $0.height.equalTo(hasNotch ? 30 : 20)
                    $0.leading.trailing.equalTo(button)
                    $0.top.equalTo(button.snp.bottom).offset(8)
                }
                
                subButton.addTarget(self, action: #selector(touchSubButton), for: .touchUpInside)
            }
        }
    }
    
    private let hasNotch = UIDevice.current.hasNotch
    
// MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        initNavigationBar()
        setLayouts()
        addTargets()
        setUp()
    }
    
// MARK: - Public Functions
    
    @objc public func touchButton() {}
    @objc public func touchSubButton() {}
    public func setUp() {}

// MARK: - Private Functions
    
    private func addTargets() {
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
    }
    
    private func render() {
        view.backgroundColor = .White
    }
    
    private func initNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setLayouts() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        view.addSubviews(button, label, graphicView, descriptionView)
    }
    
    private func setConstraints() {
        button.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(40)
        }
        
        label.snp.makeConstraints {
            $0.height.equalTo(104)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(hasNotch ? 74 : 50)
            $0.leading.trailing.equalToSuperview().inset(44)
        }
        
        graphicView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(hasNotch ? 10 : 20)
            $0.height.equalTo(graphicView.snp.width)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(hasNotch ? 152 : 100)
        }
        
        descriptionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.top.equalTo(graphicView.snp.bottom).offset(10)
            $0.bottom.equalTo(button.snp.top).offset(-10)
        }
    }

}
