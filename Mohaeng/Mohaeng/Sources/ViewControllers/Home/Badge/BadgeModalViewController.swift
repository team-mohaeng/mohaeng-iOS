//
//  BottomModalViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/09/18.
//

import UIKit

import SnapKit
import Then

class BadgeModalViewController: UIViewController {
    
    // MARK: - Properties
    private var badge: Badge?
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = .White
    }
    
    private let badgeImageView = UIImageView()
    
    private let nameLabel = UILabel().then {
        $0.font = .gmarketFont(weight: .medium, size: 18)
        $0.textAlignment = .center
    }
    
    private let infoLabel = UILabel().then {
        $0.font = .spoqaHanSansNeo(weight: .regular, size: 14)
        $0.textColor = .Grey2
        $0.numberOfLines = 2
    }
    
    struct Constraint {
        var viewHeight: CGFloat
        var imageViewTop: CGFloat
        var nameLabelTop: CGFloat
        
        init(hasBadge: Bool) {
            if hasBadge {
                viewHeight = 279
                imageViewTop =  60
                nameLabelTop = 26
            } else {
                viewHeight = 303
                imageViewTop = 40
                nameLabelTop = 20
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    init(badge: Badge) {
        super.init(nibName: nil, bundle: nil)
        self.badge = badge
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeRoundedSpecificCorner()
    }
    
    // MARK: - Functions
    private func makeRoundedSpecificCorner() {
        backgroundView.makeRoundedSpecificCorner(corners: [.topLeft, .topRight], cornerRadius: 40)
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        view.addSubview(backgroundView)
        backgroundView.addSubviews(badgeImageView, nameLabel, infoLabel)
    }
    
    private func setConstraints() {
        guard let badge = badge else {return}
        let constraint = Constraint(hasBadge: badge.hasBadge)
        infoLabel.isHidden = badge.hasBadge
        
        backgroundView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(constraint.viewHeight + view.safeAreaInsets.bottom)
        }
        
        badgeImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(constraint.imageViewTop)
            $0.width.height.equalTo(112)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(badgeImageView.snp.bottom).offset(constraint.nameLabelTop)
            $0.leading.trailing.equalToSuperview().inset(42)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(42)
        }
                
    }
    
    private func setData() {
        guard let badge = badge else {return}
        badgeImageView.image = UIImage(named: badge.image)
        nameLabel.text = badge.name
        infoLabel.text = badge.info
    }
    
}
