//
//  MyPageViewController.swift
//  Mohaeng
//
//  Created by 초이 on 2021/09/16.
//

import UIKit

class MyPageViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var bgCircleView: UIView!
    @IBOutlet weak var shadowStackView: UIStackView!
    @IBOutlet weak var summaryStackView: UIStackView!
    @IBOutlet weak var calendarShadowView: UIView!
    @IBOutlet weak var calendarBgView: UIView!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initTransparentNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
    }
    
    private func initViewRounding() {
        bgCircleView.makeRounded(radius: self.bgCircleView.frame.height / 2)
        
        for summaryView in summaryStackView.subviews {
            summaryView.makeRounded(radius: 14)
        }
        
        for shadowView in shadowStackView.subviews {
            shadowView.makeRounded(radius: 14)
            shadowView.layer.shadowOpacity = 0.05
            shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
            shadowView.layer.shadowRadius = 20
            shadowView.layer.masksToBounds = false
        }
        
//        calendarShadowView.makeRounded(radius: 14)
        calendarShadowView.layer.shadowOpacity = 0.05
        calendarShadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        calendarShadowView.layer.shadowRadius = 20
        calendarShadowView.layer.masksToBounds = false
        
        calendarBgView.makeRounded(radius: 14)
    }

}
