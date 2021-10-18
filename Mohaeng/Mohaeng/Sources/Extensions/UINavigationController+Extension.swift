//
//  UINavigationController+Extension.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

extension UINavigationController {
    var previousViewController: UIViewController? {
       viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }
}

// MARK: - NEW

extension UINavigationController {
    
    // MARK: - 투명
    
    func initTransparentNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - 뒤로가기 버튼
    
    func initWithBackButton(backgroundColor: UIColor? = nil) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.initBackButtonAppearance()
        
        if backgroundColor != nil {
            appearance.backgroundColor = backgroundColor
        }
        
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.tintColor = .black
    }
    
    // MARK: - 뒤로가기 버튼 + 완료 버튼
    
    func initWithBackAndDoneButton(navigationItem: UINavigationItem?, doneButtonClosure: Selector) {
        initWithBackButton()
        
        // done Button
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self.topViewController, action: doneButtonClosure)
        navigationItem?.rightBarButtonItem = doneButton
    }
    
    // MARK: - 뒤로가기 버튼 + 커스텀 버튼 1개
    
    func initWithOneCustomButton(navigationItem: UINavigationItem?, firstButtonImage: UIImage, firstButtonClosure: Selector) {
        initWithBackButton()
        
        let firstButton = UIBarButtonItem(image: firstButtonImage, style: .plain, target: self.topViewController, action: firstButtonClosure)
        navigationItem?.rightBarButtonItem = firstButton
        
    }
    
    // MARK: - 커스텀 버튼 3개 - 메인에서만 사용
    
    func initWithThreeCustomButtons(navigationItem: UINavigationItem?, firstButton: UIBarButtonItem, secondButton: UIBarButtonItem, thirdButton: UIBarButtonItem) {
        initTransparentNavBar()
        
        let spacing = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacing.width = 16
        navigationItem?.rightBarButtonItems = [thirdButton, spacing, secondButton, spacing, firstButton]
    }
    
    // MARK: - 뒤로가기 버튼 + 닫기 버튼 - 글쓰기 뷰에서만 사용
    
    func initWithBackAndCloseButton(navigationItem: UINavigationItem?, closeButtonClosure: Selector) {
        initWithBackButton()
        
        let closeButton = UIBarButtonItem(image: Const.Image.gnbIconX, style: .plain, target: self.topViewController, action: closeButtonClosure)
        navigationItem?.rightBarButtonItem = closeButton
    }
    
    // MARK: - @objc function
    
//    @objc func touchBackButton() {
//        popViewController(animated: true)
//    }
}

extension UINavigationBarAppearance {
    
    func initBackButtonAppearance() {
        // back button image
        var backButtonImage: UIImage? {
            return Const.Image.gnbIcnBack
        }
        // back button appearance
        var backButtonAppearance: UIBarButtonItemAppearance {
            let backButtonAppearance = UIBarButtonItemAppearance()
            // backButton하단에 표출되는 text를 안보이게 설정
            backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0.0)]

            return backButtonAppearance
        }
        self.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        self.backButtonAppearance = backButtonAppearance
    }
}

















extension UINavigationController {
    
    // MARK: - Functions
    
    // navi bar 숨기기
    func hideNavigationBar() {
        // navigation bar 투명화
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        // navigation bar 숨기기
        isNavigationBarHidden = true
    }
    
    // back button이 있는 navi bar
    func initNavigationBarWithBackButton(navigationItem: UINavigationItem?) {
        isNavigationBarHidden = false
        navigationBar.barTintColor = UIColor.white
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // back button 설정
        let backButton = UIBarButtonItem(image: Const.Image.gnbIcnBack, style: .plain, target: self, action: #selector(touchBackButton))
        backButton.tintColor = .GreyIconGnb

        navigationItem?.leftBarButtonItem = backButton
    }
    
    @objc func touchBackButton() {
        popViewController(animated: true)
    }
    
    // back button이 없는 navi bar
    func initNavigationBarWithoutBackButton(navigationItem: UINavigationItem?) {
        isNavigationBarHidden = false
        navigationBar.barTintColor = UIColor.white
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        // back button 숨기기
        navigationItem?.hidesBackButton = true
    }
    
    func initTransparentNavigationBarWithoutBackButton(navigationItem: UINavigationItem?) {
        isNavigationBarHidden = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        // back button 숨기기
        navigationItem?.hidesBackButton = true
    }
    
    func initTransparentNavigationBarWithBackButton(navigationItem: UINavigationItem?) {
        isNavigationBarHidden = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        
        // back button 설정
        let backButton = UIBarButtonItem(image: Const.Image.gnbIcnBack, style: .plain, target: self, action: #selector(touchBackButton))
        backButton.tintColor = UIColor.black

        navigationItem?.leftBarButtonItem = backButton
    }
}
