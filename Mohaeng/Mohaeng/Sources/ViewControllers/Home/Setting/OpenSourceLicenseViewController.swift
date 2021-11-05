//
//  OpenSourceLicenseViewController.swift
//  Mohaeng
//
//  Created by 초이 on 2021/11/05.
//

import UIKit

class OpenSourceLicenseViewController: UIViewController {
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton(backgroundColor: .white)
        self.navigationItem.title = "오픈소스 라이선스"
    }
}
