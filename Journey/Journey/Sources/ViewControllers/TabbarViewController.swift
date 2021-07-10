//
//  TabbarViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initTabbar()
    }
    
    private func initTabbar() {
        
        // tabbar border
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0.0
        self.tabBar.clipsToBounds = true
        
        // background
        let backgroundframe = CGRect(x: self.tabBar.frame.origin.x, y: self.tabBar.frame.origin.y, width: self.tabBar.frame.width, height: self.tabBar.frame.height + 50)
        let backgroundView = UIView(frame: backgroundframe)
        backgroundView.backgroundColor = UIColor.clear
        
        // rounded view
        let roundedView = UIView(frame: CGRect(x: 0, y: 0, width: self.tabBar.frame.width, height: self.tabBar.frame.height + 50))
        roundedView.backgroundColor = UIColor.white
        roundedView.makeRoundedWithBorder(radius: 24, color: UIColor.TabbarBorderGray.cgColor)
        backgroundView.addSubview(roundedView)
        
        // set tabbar background image
        self.tabBar.backgroundImage = backgroundView.asImg
    }

}
