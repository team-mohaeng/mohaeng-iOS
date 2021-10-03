//
//  FeedDetailCollectionViewCell.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/09/16.
//

import UIKit
import SnapKit

class FeedDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    private lazy var stackView = UIStackView(arrangedSubviews: [postInfoView, imageContainerView, contentsInfoView]).then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .fill
    }
    
    private lazy var postInfoView = UIView()
    private lazy var imageContainerView = UIView()
    private lazy var contentsInfoView = UIView()
    
    private var moodImageView = UIImageView().then {
        $0.image = UIImage(named: "mood")
    }
    
    private var nicknameLabel = UILabel().then {
        $0.font = UIFont.spoqaHanSansNeo(weight: .bold, size: 16)
    }
    
    private var dateLabel = UILabel().then {
        $0.font = UIFont.spoqaHanSansNeo(weight: .regular, size: 10)
    }
    
    private var noImageLineView = UIView().then {
        $0.backgroundColor = UIColor.init(red: 0.879, green: 0.879, blue: 0.879, alpha: 1)
    }
    
    private var uploadedImageView = UIImageView()
    
    private var courseDayLabel = UILabel().then {
        $0.font = UIFont.gmarketFont(size: 14)
    }
    
    private var contentsLabel = UILabel().then {
        $0.font = UIFont.spoqaHanSansNeo(size: 14)
        $0.numberOfLines = 0
    }
    
    private var seperatorLine = UILabel().then {
        $0.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    }
    
    private var stickerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout()).then {
        if let collectionViewLayout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        $0.backgroundColor = .white
    }
    
    // MARK: - Properteis
    
    var stickerDummy: [Emoji] = []
    var hasImage: Bool = false
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViewHierachy()
        setUpLayout()
        registerCell()
        setDelegation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func registerCell() {
        stickerCollectionView.register(UINib(nibName: Const.Xib.Name.stickerCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.stickerCollectionViewCell)
        stickerCollectionView.register(UINib(nibName: Const.Xib.Name.plusButtonCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.plusButtonCollectionViewCell)
    }
    
    private func setDelegation() {
        stickerCollectionView.dataSource = self
    }
    
    func setData(feed: Feed) {
        nicknameLabel.text = feed.nickname
        dateLabel.text = feed.month + "월 " + feed.day + "일"
        courseDayLabel.text = "\(feed.course) \(feed.challenge)일차"
        contentsLabel.text = feed.content
        stickerDummy = feed.emoji
        stickerCollectionView.reloadData()
        if let image = UIImage(named: feed.image) {
            uploadedImageView.image = image
            configureImageUI(hasImage: true)
        } else {
            configureImageUI(hasImage: false)
        }
    }
    
    private func configureImageUI(hasImage: Bool) {
        imageContainerView.isHidden = !hasImage
        noImageLineView.isHidden = hasImage
    }
    
    func getDynamicContentsHeight() -> CGFloat {
        return contentsLabel.bounds.height
    }
    
    func getDynamicCollectionViewHeight() -> CGFloat {
        return stickerCollectionView.collectionViewLayout.collectionViewContentSize.height
    }

}

// MARK: - UIColelctionViewDataSource

extension FeedDetailCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickerDummy.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = stickerCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.plusButtonCollectionViewCell, for: indexPath) as? PlusButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        default:
            guard let cell = stickerCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.stickerCollectionViewCell, for: indexPath) as? StickerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setData(text: "\(stickerDummy[indexPath.row - 1].emojiCount)")
            
            return cell
        }
    }
}

// MARK: - AutoLayout

extension FeedDetailCollectionViewCell {
    
    private func setViewHierachy() {
        addSubviews(stackView, seperatorLine)
        
        postInfoView.addSubviews(moodImageView, nicknameLabel, dateLabel, noImageLineView)
        imageContainerView.addSubview(uploadedImageView)
        contentsInfoView.addSubviews(courseDayLabel, contentsLabel, stickerCollectionView)
    }
    
    private func setUpLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        postInfoView.snp.makeConstraints {
            $0.height.equalTo(90)
        }

        imageContainerView.snp.makeConstraints {
            $0.height.equalTo(stackView.snp.width)
        }
        
        /// postInfoView
        
        moodImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(24)
        }

        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(moodImageView.snp.trailing).offset(12)
            $0.bottom.equalTo(dateLabel.snp.top)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(moodImageView.snp.trailing).offset(12)
            $0.bottom.equalTo(moodImageView.snp.bottom)
        }
        
        noImageLineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        /// imageContainerView
    
        uploadedImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        /// contentsInfoView
        
        courseDayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(22)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(courseDayLabel.snp.bottom).offset(12)
            $0.leading.equalTo(courseDayLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-24)
        }

        stickerCollectionView.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(24)
            $0.leading.equalTo(contentsLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-24)
            $0.bottom.equalToSuperview().offset(-28)
        }
        
        seperatorLine.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
}

// MARK: - Custom UICollectionViewFlowLayout

class CollectionViewLeftAlignFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 6
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
