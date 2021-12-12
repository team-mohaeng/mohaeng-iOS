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
    
    func showToast(message: String, font: UIFont) {
            let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2 - 106, y: self.view.frame.size.height - 120, width: 240, height: 35))
            toastLabel.backgroundColor = .Yellow5
            toastLabel.textColor = .Black
            toastLabel.font = font
            toastLabel.textAlignment = .center
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10
            toastLabel.clipsToBounds = true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 1.0, delay: 3, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        }
    
}
