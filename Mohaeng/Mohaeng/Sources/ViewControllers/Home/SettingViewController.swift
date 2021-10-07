//
//  SettingViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/14.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: - Properties
    
    var settingTitles = ["알림설정", "도움말", "문의하기", "버전정보", "이용약관", "개인정보처리방침", "오픈소스 라이선스"]
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var settingTableView: UITableView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegation()
        initNavigationBar()
    }
    
    // MARK: - Functions

    private func setDelegation() {
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
        navigationItem.title = "환경설정"
    }
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = settingTableView.dequeueReusableCell(withIdentifier: "settingTableViewCell") as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setLabel(title: settingTitles[indexPath.row])
        
        return cell
    }
    
}
