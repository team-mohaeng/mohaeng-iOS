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
    
// MARK: - Properties
    
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

// MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iniViewController()
        
        setDelegation()
        setLayout()
        registerXib()
        initHeaderView()
    }
    
// MARK: - Functions

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
    
    private func registerXib() {
        
        tableView.register(UINib(nibName: Const.Xib.Name.firstDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.firstDayTableViewCell)
        tableView.register(UINib(nibName: Const.Xib.Name.evenDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.evenDayTableViewCell)
        tableView.register(UINib(nibName: Const.Xib.Name.oddDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.oddDayTableViewCell)
        
        tableView.register(UINib(nibName: Const.Xib.Name.courseHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Const.Xib.Identifier.courseHeaderView)
        tableView.register(UINib(nibName: Const.Xib.Name.courseFooterView, bundle: nil), forHeaderFooterViewReuseIdentifier: Const.Xib.Identifier.courseFooterView)
    }
    
    private func initHeaderView() {
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableHeaderView?.frame.size.height = view.safeAreaLayoutGuide.layoutFrame.height - topbarHeight + 36
    }

}

// MARK: - UITableViewDelegate

extension OnBoarding3ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Const.Xib.Identifier.courseHeaderView) as? CourseHeaderView {
            
            headerView.headerBgView.makeRoundedSpecificCorner(corners: [.bottomLeft, .bottomRight], cornerRadius: 25)
            headerView.layer.shadowOpacity = 0.12
            headerView.layer.shadowRadius = 0
            headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            headerView.layer.shadowColor = UIColor.black.cgColor
            
            headerView.setProperty(by: course?.rawValue ?? 0)
            headerView.setCourseName(name: course?.getOnboardingCourse()[0] ?? "")
            
            return headerView
        }
        
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Const.Xib.Identifier.courseFooterView) as? CourseFooterView {
            footerView.setIslandImage(isDone: false)
            footerView.setNextButton(isOnboarding: true)
            footerView.onboardingCourseProtocol = self
            footerView.initLastPath(isDone: false)
            return footerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 코스 진행 셀
        if indexPath.row == 0 {
            return 250
        }
        
        return 160
    }

}

// MARK: - UITableViewDataSource

extension OnBoarding3ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isDone ? 3 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 코스 진행 셀
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.firstDayTableViewCell) as? FirstDayTableViewCell {
                
                cell.setOnboardingCell(challengeName: course!.getOnboardingCourse()[1], property: course!.rawValue)
                cell.setNextSituation(next: 0)
                cell.appCourse = course ?? AppCourse(rawValue: 1)!
                
                return cell
            }
            return UITableViewCell()
        }
        
        if indexPath.row % 2 == 1 {
            // 짝수일차
            if let cell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.evenDayTableViewCell) as? EvenDayTableViewCell {
                
                cell.setCell(challenge: TodayChallenge(day: 0, situation: 0, title: "", happy: 0, beforeMent: "", afterMent: "", year: "", month: "", date: "", badges: []), property: 0)
                cell.setNextSituation(next: 0)
                
                return cell
            }
            return UITableViewCell()
        } else {
            // 홀수일차
            if let cell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.oddDayTableViewCell) as? OddDayTableViewCell {
                
                cell.setCell(challenge: TodayChallenge(day: 0, situation: 0, title: "", happy: 0, beforeMent: "", afterMent: "", year: "", month: "", date: "", badges: []), property: 0)
                cell.setNextSituation(next: 0)
                
                return cell
            }
            return UITableViewCell()
        }
    }
}

// MARK: - OnBoardingChallengeCardViewDelegate

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

// MARK: - ChallengePopUpProtocol

extension OnBoarding3ViewController: ChallengePopUpProtocol {
    func touchHelpButton(_ sender: UIButton) {}
    
    func touchStampButton(_ sender: UITapGestureRecognizer) {}
    
    func pushToFinishViewController() {}
    
    func pushToNextOnboardingViewController() {
        isDone = true
    }
    
}

extension OnBoarding3ViewController: OnboardingCourseProtocol {
    func touchNextButton(_ sender: UIButton) {
        let viewController = OnBoarding4ViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
