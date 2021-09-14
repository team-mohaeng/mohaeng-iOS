//
//  UIViewController+Extension.swift
//  Journey
//
//  Created by 초이 on 2021/07/14.
//

import UIKit

extension UIViewController {

    // Height of status bar + navigation bar (if navigation bar exist)
    var topbarHeight: CGFloat {
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        return (statusBarHeight) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
