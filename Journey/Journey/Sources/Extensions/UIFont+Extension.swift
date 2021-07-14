//
//  UIFont+Extension.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/14.
//

import Foundation
import UIKit

enum SpoqaHanSansNeoSize {
    case bold
    case light
    case medium
    case regular
    case thin
}

extension UIFont {
    static func spoqaHanSansNeo(weight: SpoqaHanSansNeoSize = .regular, size: CGFloat = 12) -> UIFont {
        let upperCaseFontSize = "\(weight)".capitalized
        return UIFont(name: "SpoqaHanSansNeo-\(upperCaseFontSize)", size: size)!
    }
}
