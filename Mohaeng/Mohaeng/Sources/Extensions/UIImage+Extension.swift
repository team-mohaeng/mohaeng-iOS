//
//  UIImage+Extension.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/03.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
