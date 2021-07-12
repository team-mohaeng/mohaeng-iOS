//
//  UIDevice+Extension.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/12.
//

import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}


