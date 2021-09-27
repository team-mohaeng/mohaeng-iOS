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

enum GmarketFontSize {
    case light
    case bold
    case medium
}

extension UIFont {
    static func spoqaHanSansNeo(weight: SpoqaHanSansNeoSize = .regular, size: CGFloat = 12) -> UIFont {
        let upperCaseFontSize = "\(weight)".capitalized
        return UIFont(name: "SpoqaHanSansNeo-\(upperCaseFontSize)", size: size)!
    }
    
    static func gmarketFont(weight: GmarketFontSize = .medium, size: CGFloat = 12) -> UIFont {
        let upperCaseFontSize = "\(weight)".capitalized
        return UIFont(name: "GmarketSansTTF\(upperCaseFontSize)", size: size)!
    }
}
