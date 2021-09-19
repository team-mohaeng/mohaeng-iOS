//
//  BadgeCollectionViewCell.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/09/18.
//

import UIKit

import Then
import SnapKit

class BadgeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let imageView = UIImageView()
    
    private let nameLabel = UILabel().then {
        $0.text = " "
        $0.font = .gmarketFont(weight: .medium, size: 12)
        $0.textAlignment = .center
    }
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCollectionViewCell()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    // MARK: - Functions
    private func initCollectionViewCell() {
        contentView.backgroundColor = .white
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        contentView.addSubviews(imageView, nameLabel)
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24.5)
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-37)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(imageView)
        }
    }
    
    public func setData(badge: Badge) {
        imageView.image = UIImage(named: badge.image)
        nameLabel.text = badge.name
    }
    
}
