//
//  CourseViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit
import Moya

class CourseViewController: UIViewController {
    
    // MARK: - Properties

    // default data
    var course: Course = Course(id: 0, title: "", courseDescription: "", totalDays: 0, situation: 0, property: 0, challenges: [
        Challenge(id: 0, situation: 0, title: "", challengeDescription: "", successDescription: "", year: "", month: "", day: "", currentStamp: 0, totalStamp: 0, userMents: []),
        Challenge(id: 0, situation: 0, title: "", challengeDescription: "", successDescription: "", year: "", month: "", day: "", currentStamp: 0, totalStamp: 0, userMents: [])
    ])

    var backgroundView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var headerView: ChallengeStampView?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var courseTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        registerXib()
        assignDelegation()
        initViewRounding()
        getCourse()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.initHeaderView()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        // TODO: - right button 추가
    }
    
    private func registerXib() {
        self.headerView = Bundle.main.loadNibNamed(Const.Xib.Name.challengeStampView, owner: self, options: nil)?.last as? ChallengeStampView
        
        courseTableView.register(UINib(nibName: Const.Xib.Name.firstDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.firstDayTableViewCell)
        courseTableView.register(UINib(nibName: Const.Xib.Name.evenDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.evenDayTableViewCell)
        courseTableView.register(UINib(nibName: Const.Xib.Name.oddDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.oddDayTableViewCell)
        
        courseTableView.register(UINib(nibName: Const.Xib.Name.courseHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Const.Xib.Identifier.courseHeaderView)
        courseTableView.register(UINib(nibName: Const.Xib.Name.courseFooterView, bundle: nil), forHeaderFooterViewReuseIdentifier: Const.Xib.Identifier.courseFooterView)
    }
    
    private func assignDelegation() {
        courseTableView.delegate = self
        courseTableView.dataSource = self
    }
    
    private func initViewRounding() {
    }
    
    private func initHeaderView() {
        let tabBarHeight = tabBarController?.tabBar.bounds.size.height ?? 0
        
        self.courseTableView.tableHeaderView = self.headerView
        self.courseTableView.tableHeaderView?.frame.size.height = UIScreen.main.bounds.height - topbarHeight - tabBarHeight
    }
    
    func updateData(data: CourseData) {
        self.course = data.course
        
        // table view
        self.courseTableView.reloadData()
        
    }
    
    func findCourseProgressDay(challenges: [Challenge]) -> Int {
        var day = 0
        for challenges in challenges {
            if challenges.situation == 0 {
                return day
            }
            day += 1
        }
        return day
    }
    
}

// MARK: - UITableViewDelegate

extension CourseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 250
        }
        
        return 160
    }
    
    // section header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Const.Xib.Identifier.courseHeaderView) as? CourseHeaderView {
            
            headerView.headerBgView.makeRoundedSpecificCorner(corners: [.bottomLeft, .bottomRight], cornerRadius: 10)
            headerView.layer.shadowOpacity = 0.12
            headerView.layer.shadowRadius = 0
            headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
            headerView.layer.shadowColor = UIColor.black.cgColor
            
            return headerView
        }
        
        return UIView()
    }
    
    // section footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Const.Xib.Identifier.courseFooterView) as? CourseFooterView {
            if course.challenges[course.challenges.count - 1].situation == 2 {
                footerView.isDone = .done
            } else {
                footerView.isDone = .undone
            }
            footerView.initLastPath()
            return footerView
        }
        return UIView()
    }
}

// MARK: - UITableViewDataSource

extension CourseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course.challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = courseTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.firstDayTableViewCell) as? FirstDayTableViewCell {
                
                cell.setCell(challenge: course.challenges[indexPath.row])
                cell.setNextSituation(next: course.challenges[indexPath.row + 1].situation)
                cell.property = course.property
                
                return cell
            }
            return UITableViewCell()
        }
        
        if indexPath.row % 2 == 1 {
            // 짝수일차
            if let cell = courseTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.evenDayTableViewCell) as? EvenDayTableViewCell {
                
                cell.setCell(challenge: course.challenges[indexPath.row])
                
                if indexPath.row < course.challenges.count-1 {
                    cell.setNextSituation(next: course.challenges[indexPath.row + 1].situation)
                }
                cell.property = course.property
                
                return cell
            }
            return UITableViewCell()
        } else {
            // 홀수일차
            if let cell = courseTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.oddDayTableViewCell) as? OddDayTableViewCell {
                
                cell.setCell(challenge: course.challenges[indexPath.row])
                
                if indexPath.row < course.challenges.count-1 {
                    cell.setNextSituation(next: course.challenges[indexPath.row + 1].situation)
                } else {
                    // 맨 마지막 cell일 때
                    cell.setNextSituation(next: 9)
                }
                cell.property = course.property
                
                return cell
            }
            return UITableViewCell()
        }
    }
}

// MARK: - 서버 통신

extension CourseViewController {

    func getCourse() {
        
        ChallengeAPI.shared.getAllChallenges { (response) in
            
            switch response {
            case .success(let course):
                
                if let data = course as? CourseData {
                    self.updateData(data: data)
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
}
