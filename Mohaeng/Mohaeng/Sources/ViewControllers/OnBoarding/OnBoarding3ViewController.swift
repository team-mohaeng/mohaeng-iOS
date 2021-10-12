//
//  OnBoarding3ViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/10.
//

import UIKit

import SnapKit
import Then

class OnBoarding3ViewController: UIViewController {
    
    public var course: AppCourse? {
        didSet {
            headerView.course = course
        }
    }
    
    public var isDone: Bool = false {
        didSet {
            headerView.isDone = isDone
            tableView.isScrollEnabled = isDone
            tableView.reloadData()
        }
    }
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.backgroundColor = .White
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        $0.tableHeaderView = UIView(frame: frame)
       
    }
    
    private let headerView = OnBoarding3HeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iniViewController()
        
        setDelegation()
        setLayout()
    }
    
    private func iniViewController() {
        view.backgroundColor = .White
    }
    
    private func setDelegation() {
        tableView.delegate = self
        tableView.dataSource = self
        headerView.delegate = self
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        view.addSubviews(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

}

extension OnBoarding3ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.safeAreaLayoutGuide.layoutFrame.height
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 코스 진행 셀
        return 600
    }

}

extension OnBoarding3ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isDone ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 코스 진행 셀
        return UITableViewCell()
    }
}

extension OnBoarding3ViewController: OnBoardingChallengeCardViewDelegate {
    func touchChallengeImageView() {
        let completePopUp = ChallengeCompletePopUpViewController()
        completePopUp.modalTransitionStyle = .crossDissolve
        completePopUp.modalPresentationStyle = .overCurrentContext
        completePopUp.popUpUsage = .onboarding
        completePopUp.challengePopUpProtocol = self
                
        self.present(completePopUp, animated: true, completion: nil)
    }
}

extension OnBoarding3ViewController: ChallengePopUpProtocol {
    func touchHelpButton(_ sender: UIButton) {}
    
    func touchStampButton(_ sender: UITapGestureRecognizer) {}
    
    func pushToFinishViewController() {}
    
    func pushToNextOnboardingViewController() {
        isDone = true
    }
    
}
