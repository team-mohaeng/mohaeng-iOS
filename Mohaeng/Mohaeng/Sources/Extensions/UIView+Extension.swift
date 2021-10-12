//
//  UIView+Extension.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

extension UIView {
    
    func makeRounded(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func makeRoundedWithBorder(radius: CGFloat, color: CGColor, borderWith: CGFloat = 1) {
        makeRounded(radius: radius)
        self.layer.borderWidth = borderWith
        self.layer.borderColor = color
    }
    
    // 선택한 꼭짓점 Rounding
    func makeRoundedSpecificCorner(corners: UIRectCorner, cornerRadius: Double) {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
    
    // UIView to UIImage (with all subviews)
    var asImg: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    // UIView 여러 개 인자로 받아서 한 번에 addSubview
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func dropShadowWithMaskLayer(rounded: CGFloat) {
        let margin = 24
        let maximumRadiusValue: CGFloat = 50
        
        /// layer 생성 후 크기 설정
        let maskLayer = CAShapeLayer()
        var bounds = self.bounds
        if self.frame.width > self.frame.height {
            /// course info view에서 width bounds가 제대로 인식이 안되는 이슈로 인해 양옆 margin 값 직접 넣어줌
            bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - CGFloat(margin * 2), height: self.bounds.height)
        }
        maskLayer.frame = bounds
        maskLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.cornerRadius).cgPath
        
        /// mask 영역을 뷰보다 크게 만들어서 mask에 의해 shadow가 잘리지 않도록 함
        let shadowBorder: CGFloat = self.layer.shadowRadius * 2 + maximumRadiusValue
        maskLayer.frame = maskLayer.frame.insetBy(dx: -shadowBorder, dy: -shadowBorder)
        maskLayer.frame = maskLayer.frame.offsetBy(dx: shadowBorder / 2, dy: shadowBorder / 2)
        
        /// 내부 경로 그려서 겹치는 부분 잘라내기
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        let pathMasking = CGMutablePath()
        pathMasking.addPath(UIBezierPath(rect: maskLayer.bounds).cgPath)
        var catShiftBorder = CGAffineTransform(translationX: shadowBorder / 2, y: shadowBorder / 2)
        pathMasking.addPath(maskLayer.path!.copy(using: &catShiftBorder)!)
        maskLayer.path = pathMasking
        
        self.layer.mask = maskLayer
        dropShadow(rounded: rounded)
    }
    
    func dropShadow(rounded: CGFloat) {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = rounded
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
    }
    
    func addShadowWithOpaqueBackground(opacity: Float, radius: CGFloat) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    func animateBottomToTopWithOpacity() {
        self.alpha = 0.2
        UIView.animate(withDuration: 1) {[weak self] in
            guard let self = self else {return}
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y-40, width: self.frame.width, height: self.frame.height)
            self.alpha = 1
        }
    }
    
    func animateWithOpacity() {
        self.alpha = 0.2
        UIView.animate(withDuration: 1) {[weak self] in
            self?.alpha = 1
        }
    }
}
