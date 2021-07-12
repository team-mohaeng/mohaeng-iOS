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
    
    func makeRoundedWithBorder(radius: CGFloat, color: CGColor) {
        makeRounded(radius: radius)
        self.layer.borderWidth = 1
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
}
