//
//  OnBoarding2HeaderView.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/12.
//

import UIKit

import SnapKit
import Then

class OnBoarding2HeaderView: UIView {
    
// MARK: - Properties
    
    public let label = UILabel().then {
        $0.makeTyping(text: """
                    모행에서는 다양한 종류의
                    챌린지를 진행할 수 있어.
                    
                    꽂히는 코스를 하나 선택해봐~!
                    """, highlightedText: "코스")
        $0.font = .gmarketFont(weight: .medium, size: 16)
        $0.numberOfLines = 0
    }
    
    private let rightCharacterImageView = UIImageView().then {
        $0.image = Const.Image.grpXonboarding3
    }
    
// MARK: - View Life Cycle
    
    public init() {
        super.init(frame: CGRect.zero)
        initView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        backgroundColor = .White
    }
    
// MARK: - Functions
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        addSubviews(label, rightCharacterImageView)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIDevice.current.hasNotch ? 44 : 32)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        rightCharacterImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(6)
            $0.width.equalTo(98)
            $0.height.equalTo(160)
        }
    }
}
