//
//  RoadMapCGPoint.swift
//  Journey
//
//  Created by 초이 on 2021/08/23.
//

import UIKit

// Size를 CGPoint에서 바로 사용하기 위해 struct로 namespace 생성
struct RoadMapPath {
    
    // MARK: - Properties
    var centerY: CGFloat = 0
    
    // MARK: Points
    private let topLeftCircleStart: CGPoint
    private let topLeftCircleCenter: CGPoint
    
    private let topRightCircleStart: CGPoint
    private let topRightCircleCenter: CGPoint
    
    private let bottomLeftCircleStart: CGPoint
    private let bottomLeftCircleCenter: CGPoint
    
    private let bottomRightCircleStart: CGPoint
    private let bottomRightCircleCenter: CGPoint
    
    private let leftCirclesContact: CGPoint
    private let rightCirclesContact: CGPoint
    private let centerOfContacts: CGPoint
    
    // MARK: - Size Enum
    
    enum Size {
        // all
        static let radius: CGFloat = 80
        static let horizontalSpacing: CGFloat = 29
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let strokeSize: CGFloat = 10 // 선 굵기
        static let startOffset: CGFloat = 10
    }
    
    // MARK: - Init Functions
    
    init(centerY: CGFloat) {
        self.centerY = centerY
        
        // MARK: Init Points
        topLeftCircleStart = CGPoint(x: Size.horizontalSpacing, y: centerY - Size.radius)
        topLeftCircleCenter = CGPoint(x: Size.horizontalSpacing + Size.radius, y: centerY - Size.radius)
        
        topRightCircleStart = CGPoint(x: Size.screenWidth - Size.horizontalSpacing, y: centerY - Size.radius)
        topRightCircleCenter = CGPoint(x: Size.screenWidth - Size.horizontalSpacing - Size.radius, y: centerY - Size.radius)
        
        bottomLeftCircleStart = CGPoint(x: Size.horizontalSpacing, y: centerY + Size.radius)
        bottomLeftCircleCenter = CGPoint(x: Size.horizontalSpacing + Size.radius, y: centerY + Size.radius)
        
        bottomRightCircleStart = CGPoint(x: Size.screenWidth - Size.horizontalSpacing, y: centerY + Size.radius)
        bottomRightCircleCenter = CGPoint(x: Size.screenWidth - Size.horizontalSpacing - Size.radius, y: centerY + Size.radius)
        
        leftCirclesContact = CGPoint(x: Size.horizontalSpacing + Size.radius, y: centerY)
        rightCirclesContact = CGPoint(x: Size.screenWidth - Size.horizontalSpacing - Size.radius, y: centerY)
        centerOfContacts = CGPoint(x: Size.screenWidth / 2, y: centerY)
    }
    
    // MARK: - Functions
    
    func getDownwardPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: topLeftCircleStart)
        path.addArc(withCenter: topLeftCircleCenter, radius: Size.radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2, clockwise: false)
        path.addLine(to: rightCirclesContact)
        path.addArc(withCenter: bottomRightCircleCenter, radius: Size.radius, startAngle: 3 * CGFloat.pi / 2, endAngle: 0, clockwise: true)
        
        return path
    }
    
    func getUpwardPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: bottomLeftCircleStart)
        path.addArc(withCenter: bottomLeftCircleCenter, radius: Size.radius, startAngle: CGFloat.pi, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        path.addLine(to: rightCirclesContact)
        path.addArc(withCenter: topRightCircleCenter, radius: Size.radius, startAngle: CGFloat.pi / 2, endAngle: 0, clockwise: false)
        
        return path
    }
    
    func getVeryLastPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: topLeftCircleStart)
        path.addArc(withCenter: topLeftCircleCenter, radius: Size.radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2, clockwise: false)
        path.addLine(to: CGPoint(x: rightCirclesContact.x + 35, y: rightCirclesContact.y))
        
        return path
    }
    
    // path의 길이
    func getPathLength() -> CGFloat {
        let arcLength: CGFloat = CGFloat( 2 * ( 2 * CGFloat.pi * Size.radius / 4 ) )
        let lineLength: CGFloat = bottomRightCircleStart.x - bottomLeftCircleCenter.x
        
        return arcLength + lineLength
    }
    
    func getDashPattern() -> NSNumber {
        let pathlength = RoadMapPath(centerY: 0).getPathLength() / 43
        let dash = pathlength
        
        return NSNumber(value: Float(dash))
    }
    
    func getBlankPattern() -> NSNumber {
        let pathlength = RoadMapPath(centerY: 0).getPathLength() / 43
        let blank = 3 * pathlength
        
        return NSNumber(value: Float(blank))
    }
    
}
