//
//  OnBoarding2HeaderView.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/12.
//

import UIKit

class OnBoarding2HeaderView: UIView {
    public let label = UILabel().then {
        $0.setTyping(text: "모행에서는 다양한 종류의\n챌린지를 진행할 수 있어.\n\n꽂히는 코스를 하나 선택해봐~!", highlightedText: "코스")
        $0.font = .gmarketFont(weight: .medium, size: 16)
        $0.numberOfLines = 0
    }
    
    private let rightCharacterImageView = UIImageView().then {
        $0.image = Const.Image.grpXonboarding3
    }
    
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
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        addSubviews(label, rightCharacterImageView)
    }
    
    private func setConstraints() {
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        rightCharacterImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(6)
            $0.width.equalTo(100)
            $0.height.equalTo(160)
        }
    }
}
