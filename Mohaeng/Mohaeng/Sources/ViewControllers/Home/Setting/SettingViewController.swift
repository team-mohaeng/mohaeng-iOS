//
//  SettingViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/14.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: - Properties
    
    var settingTitles = ["푸시 알림 설정", "개인정보처리방침", "서비스 이용약관", "오픈 소스 라이선스", "로그아웃", "회원 탈퇴", "1대 1 문의하기"]
    var askPopUp: PopUpViewController = PopUpViewController()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var settingTableView: UITableView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegation()
        initNavigationBar()
        updateVersion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
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
    
    private func presentAgreeViewController(agree: AgreeViewController.Agree) {
        let agreeStoryboard = UIStoryboard(name: Const.Storyboard.Name.agree, bundle: nil)
        guard let agreeViewController = agreeStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.agree) as?
                AgreeViewController else {
                    return
                }
        agreeViewController.agree = agree
        self.present(agreeViewController, animated: true, completion: nil)
    }
    
    private func popToLoginViewController() {
        if let loginViewController = self.navigationController?.viewControllers.filter({$0 is LoginViewController}).first as? LoginViewController {
            self.navigationController?.popToViewController(loginViewController, animated: true)
        } else {
            guard let homeViewController = self.navigationController?.viewControllers.filter({$0 is HomeViewController}).first as? HomeViewController else {
                return
            }
            homeViewController.isFromLogoutOrWithdrawal = true
            self.navigationController?.popToViewController(homeViewController, animated: true)
        }
    }
    
    private func presentWithdrawalPopUp() {
        askPopUp = PopUpViewController(nibName: Const.Xib.Name.popUp, bundle: nil)
        askPopUp.modalPresentationStyle = .overCurrentContext
        askPopUp.modalTransitionStyle = .crossDissolve
        askPopUp.popUpUsage = .twoButtonNoImage
        askPopUp.setText(title: Const.String.withdrawalPopUpTitle, description: Const.String.withdrawalPopUpContent, buttonTitle: "탈퇴")
        askPopUp.popUpActionDelegate = self
        tabBarController?.present(askPopUp, animated: true, completion: nil)
    }
    
    private func pushToOpenSourceLicenseViewController() {
        let openSourceLicenseStoryboard = UIStoryboard(name: Const.Storyboard.Name.openSourceLicense, bundle: nil)
        guard let openSourceLicenseViewController = openSourceLicenseStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.openSourceLicense) as?
                OpenSourceLicenseViewController else {
                    return
                }
        self.present(openSourceLicenseViewController, animated: true, completion: nil)
    }
    
    private func pushToMakersViewController() {
        let makersStoryboard = UIStoryboard(name: Const.Storyboard.Name.makers, bundle: nil)
        guard let makersViewController = makersStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.makers) as?
                MakersViewController else {
                    return
                }
        self.navigationController?.pushViewController(makersViewController, animated: true)
    }
    
    private func updateVersion() {
        let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"]
        guard let version = nsObject as? String else { return }
        self.versionLabel.text = "Ver. \(version)"
    }
    
    // MARK: - @IBAction Function
    
    @IBAction func touchMemberButton(_ sender: Any) {
        pushToMakersViewController()
    }
    
}

// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = settingTableView.dequeueReusableCell(withIdentifier: "settingTableViewCell") as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0: // 푸시 알림 설정
            cell.accessoryType = .none
            cell.setSwitch()
        case 4: // 로그아웃
            cell.accessoryType = .none
            cell.setRedLabel()
        case 5: // 회원 탈퇴
            cell.accessoryType = .none
            cell.setRedLabel()
        default:
            break
        }
        
        cell.setLabel(title: settingTitles[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0: // 푸시 알림 설정
            return
        case 1: // 개인정보처리방침
            self.presentAgreeViewController(agree: AgreeViewController.Agree.personal)
        case 2: // 서비스 이용약관
            self.presentAgreeViewController(agree: AgreeViewController.Agree.service)
        case 3: // 오픈 소스 라이선스
            self.pushToOpenSourceLicenseViewController()
        case 4: // 로그아웃
            UserDefaults.standard.removeObject(forKey: "jwtToken")
            popToLoginViewController()
        case 5: // 회원 탈퇴
            presentWithdrawalPopUp()
//        case 6: // 1대 1 문의하기
        default:
            return
        }
    }
}

// MARK: - PopUpActionDelegate

extension SettingViewController: PopUpActionDelegate {
    func touchGreyButton(button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func touchYellowButton(button: UIButton) {
        deleteUser()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - 통신

extension SettingViewController {
    
    func deleteUser() {
        SignUpAPI.shared.deleteUser { (response) in
            switch response {
            case .success(_):
                
                UserDefaults.standard.removeObject(forKey: "jwtToken")
                self.popToLoginViewController()
                
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
}
