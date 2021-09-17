//
//  MoodViewController+Carousel.swift
//  Mohaeng
//
//  Created by 김승찬 on 2021/09/16.
//


import UIKit

class CarouselLayout: UICollectionViewFlowLayout {
    
    public var sideItemScale: CGFloat = 0.5
    public var sideItemAlpha: CGFloat = 0.5
    public var spacing: CGFloat = 10
    
    public var isPagingEnabled: Bool = false
    private var isSetup: Bool = false
    
    override public func prepare() {
        super.prepare()
        if isSetup == false {
            setupLayout()
            isSetup = true
        }
    }
    
    //  prepare()가 처음으로 호출될 때 컬렉션 뷰에 대한 초기 설정을 하기 위해, setupLayout()이라는 함수 생성
    //  섹션 인셋, 미니멈라인 스페이싱 등 설정
    //  prepare는 사용자가 스크롤 시 매번 호출되기 때문에, isSetup이라는 프로퍼티를 만들어 초기에 딱 한 번만 호출되도록 함.
    
    private func setupLayout() {
        guard let collectionView = self.collectionView else { return }
        
        let collectionViewSize = collectionView.bounds.size
        
        let xInset = (collectionViewSize.width - self.itemSize.width) / 2
        let yInset = (collectionViewSize.height - self.itemSize.height) / 2
        
        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
        
        let itemWidth = self.itemSize.width
        
        let scaledItemOffset =  (itemWidth - itemWidth*self.sideItemScale) / 2
        self.minimumLineSpacing = spacing - scaledItemOffset
        
        self.scrollDirection = .horizontal
    }
    
    //  shouldInvalidateLayout(forBoundsChange: )의 경우 위에서도 설명했듯이 true로 반환 함으로써 사용자가 스크롤 시 prepare()를 통해 레이아웃 업데이트가 가능하게 끔 합니다.
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //  layoutAttributesForElements(in: )는 모든 셀과 뷰에 대한 레이아웃 속성을  UICollectionViewLayoutAttributes 배열로 반환
    //  속성을 변환해서 반환할 거기 때문에 고차 함수 map을 사용.
    //  map에서 전달 인자로 받는 함수에 우리가 각 아이템들을 어떻게 변환시킬 것인지에 대한 내용
    
    
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
              let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
        else { return nil }
        
        return attributes.map({ self.transformLayoutAttributes(attributes: $0) })
    }
    
    //이제 각 아이템(셀)들의 레이아웃 속성 변화를 담당할 transformLayoutAttributes 함수를 만듦.
    
    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        guard let collectionView = self.collectionView else {return attributes}
        
        let collectionCenter = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset
        
        //비율을 구하기 위해서 maxDistance와 distnace를 사용
        // maxDistance는 여기서 아이템 중앙과 아이템 중앙 사이의 거리를 의미하는 고정 값 distance의 경우 maxDistance와 collectionCenter - center의 절대 값 중 더 작은 값을 의미 그래서 distance는 0~maxDistance 값을 갖게 됨.
        
        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - center), maxDistance)
        
        //  (maxDistance - distance)/maxDistance, distance가 0이면 비율은 1, distance가 maxDistance이면 비율은 0, maxDistance는 고정 값이기 때문에 가변 값인 distance값의 변화에 따라 비율은 0~1
        
        let ratio = (maxDistance - distance)/maxDistance
        
        //    이제 위의 값들을 기반으로 하여 거리에 따른 비율을 계산하고 그 비율을 갖고서 alpha와 scale 값을 조정하는 공식 만듦.
        
        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        attributes.alpha = alpha
        
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
        attributes.transform3D = transform
        
        return attributes
    }
    
    //  페이징 기능을 하게 해주는 메서드
    //  스크롤이 중지되는 지점을 변경 가능
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2
        
        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
