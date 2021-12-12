//
//  UITextView+Extension.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/12/12.
//

import UIKit.UITextView

extension UITextView {
    func numberOfLine() -> Int {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        
        return Int(estimatedSize.height / 24)
    }
}
