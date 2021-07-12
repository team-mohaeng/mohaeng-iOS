//
//  ContentsCollectionViewCell.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/12.
//

import UIKit
import SnapKit
import Then

class ContentsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var thumbnailImageView = UIImageView()
    var effectView = UIVisualEffectView()
    var hashTagLabel = UILabel()
    var contentsLabel = UILabel()
    var nicknameLabel = UILabel()
    var likeButton = UIButton()
    var likeCountLabel = UILabel()
    var blackTransparentView = UIView()
    
    // MARK: - init function
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initThumbnailImage()
        initBlurEffect()
        initTextLabel()
        initTransparentView()
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeEffectView()
        initBlurEffect()
    }
    
    private func initThumbnailImage() {
        thumbnailImageView.then {
            $0.frame = self.bounds
            $0.image = UIImage.init(named: "sampleHappinessImg")
        }
        self.contentView.addSubview(thumbnailImageView)
    }
    
    private func initBlurEffect() {
        let effect = UIBlurEffect(style: .light)
        let effectView = CustomIntensityVisualEffectView(effect: effect, intensity: 0.1)
        effectView.frame = thumbnailImageView.bounds
        thumbnailImageView.addSubview(effectView)
        self.effectView = effectView
    }
    
    private func removeEffectView() {
        effectView.removeFromSuperview()
    }
    
    private func initTextLabel() {
        addSubviews()
        
        hashTagLabel.then {
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.text = "#맥주 #여름"
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowOpacity = 0.2
        }
        contentsLabel.then {
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.numberOfLines = 0
            $0.text = "맛있는 피자에 시원한 맥주 먹고 신선한 날씨에 산책했어요."
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowOpacity = 0.2
        }
        nicknameLabel.then {
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 10)
            $0.text = "시원스쿨"
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowOpacity = 0.2
        }
        likeCountLabel.then {
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 10)
            $0.text = "76"
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowOpacity = 0.2
        }
        likeCountLabel.then {
            $0.textColor = .white
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowOpacity = 0.2
        }
    }
    
    private func initTransparentView() {
        blackTransparentView.then {
            $0.frame = self.bounds
            $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        }
    }
    
    private func addSubviews() {
        addSubviews(hashTagLabel, contentsLabel, nicknameLabel, likeCountLabel, likeButton)
        self.contentView.insertSubview(blackTransparentView, at: 1)
    }
    
    private func initLayout() {
        hashTagLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(14)
        }
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(hashTagLabel.snp.bottom).offset(19)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
        }
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().offset(-22)
        }
        likeCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-9)
            $0.bottom.equalToSuperview().offset(-22)
        }
    }
    
}
