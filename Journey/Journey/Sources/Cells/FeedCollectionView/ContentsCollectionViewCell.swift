//
//  ContentsCollectionViewCell.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/12.
//

import UIKit
import SnapKit
import Then
import Kingfisher

enum SuperController {
    case community
    case myDrawer
}

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
    var viewController: SuperController?
    
    // MARK: - init function
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initThumbnailImage()
        initBlurEffect()
        initTextLabel()
        initTransparentView()
        initLikeButton()
        initLayout()
        addLikeButtonEvent()
        
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
            $0.contentMode = .scaleAspectFill
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
            $0.text = "#맥주 #여름"
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowOpacity = 0.2
            $0.font = UIFont.spoqaHanSansNeo(weight: .regular, size: 14)
        }
        contentsLabel.then {
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.numberOfLines = 0
            $0.text = "맛있는 피자에 시원한 맥주 먹고 신선한 날씨에 산책했어요."
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowOpacity = 0.2
            $0.font = UIFont.spoqaHanSansNeo(weight: .medium, size: 15)
        }
        nicknameLabel.then {
            $0.textColor = .white
            $0.text = "시원스쿨"
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowOpacity = 0.2
            $0.font = UIFont.spoqaHanSansNeo(weight: .regular, size: 10)
        }
        likeCountLabel.then {
            $0.textColor = .white
            $0.text = "76"
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowOpacity = 0.2
            $0.font = UIFont.spoqaHanSansNeo(weight: .regular, size: 10)
        }
    }
    
    private func initTransparentView() {
        blackTransparentView.then {
            $0.frame = self.bounds
            $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        }
    }
    
    private func initLikeButton() {
        likeButton.then {
            $0.setBackgroundImage(Const.Image.heartImg, for: .normal)
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
            $0.trailing.equalToSuperview().offset(-14)
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
        likeButton.snp.makeConstraints {
            $0.trailing.equalTo(likeCountLabel.snp.leading).offset(-4)
            $0.centerY.equalTo(likeCountLabel.snp.centerY)
        }
    }
    
    func setData(data: Community, viewController: SuperController) {
        // 호출한 뷰컨이 어딘지 알기 위함
        self.viewController = viewController
        hashTagLabel.text = data.hashtags.joined(separator: " ")
        contentsLabel.text = data.content
        nicknameLabel.text = data.nickname
        likeCountLabel.text = String(data.likeCount)
        thumbnailImageView.kf.setImage(with: URL(string: data.mainImage))
        setLikeButtonBackgroundImage(buttonStatus: data.hasLike)
    }
    
    private func addLikeButtonEvent() {
        likeButton.addTarget(self, action: #selector(touchLikeButton), for: .touchUpInside)
    }
    
    @objc func touchLikeButton() {
        likeButton.isSelected = !likeButton.isSelected
        if likeButton.isSelected {
            addLikeEventNotification(buttonStatus: true, cellIndex: getIndexPath())
            setLikeButtonBackgroundImage(buttonStatus: true)
            plusLikeCount()
        } else {
            addLikeEventNotification(buttonStatus: false, cellIndex: getIndexPath())
            setLikeButtonBackgroundImage(buttonStatus: false)
            minusLikeCount()
        }
    }
    
    private func addLikeEventNotification(buttonStatus: Bool, cellIndex: Int) {
        let likeInfo = LikeButtonInfo(isButtonClicked: buttonStatus, cellIndex: cellIndex)
        switch viewController {
        case .community:
            NotificationCenter.default.post(name: NSNotification.Name("likeButtonClicked"), object: likeInfo)
        case .myDrawer:
            NotificationCenter.default.post(name: NSNotification.Name("myDrawerLikeClicked"), object: likeInfo)
        case .none:
            return
        }
    }
    
    private func plusLikeCount() {
        guard let like = likeCountLabel.text else { return }
        guard let likeCount = Int(like) else { return }
        likeCountLabel.text = "\(likeCount + 1)"
    }
    
    private func minusLikeCount() {
        guard let like = likeCountLabel.text else { return }
        guard let likeCount = Int(like) else { return }
        likeCountLabel.text = "\(likeCount - 1)"
    }
    
    private func setLikeButtonBackgroundImage(buttonStatus: Bool) {
        switch buttonStatus {
        case true:
            likeButton.isSelected = true
            likeButton.setBackgroundImage(Const.Image.heartFullImg, for: .normal)
            likeCountLabel.textColor = .Pink2
            likeCountLabel.font = UIFont.spoqaHanSansNeo(weight: .bold, size: 10)
        case false:
            likeButton.isSelected = false
            likeButton.setBackgroundImage(Const.Image.heartImg, for: .normal)
            likeCountLabel.textColor = .white
        }
    }
    
    private func getIndexPath() -> Int {
        var indexPath = 0
        
        guard let superView = self.superview as? UICollectionView else {
            return -1
        }
        indexPath = superView.indexPath(for: self)!.row
        
        return indexPath
    }

}

struct LikeButtonInfo {
    var isButtonClicked: Bool
    var cellIndex: Int
}
