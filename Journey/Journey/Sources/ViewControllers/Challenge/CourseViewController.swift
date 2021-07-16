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
        Challenge(id: 0, situation: 0, title: "", challengeDescription: "", successDescription: "", year: "", month: "", day: "", currentStamp: 0, totalStamp: 0, userMents: []),
    ])
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var courseImageVIew: UIImageView!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var dayCountLabelBgView: UIView!
    @IBOutlet weak var dayCountLabel: UILabel!
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
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        
        navigationItem.title = "현재 진행중인 코스"
        
    }
    
    private func registerXib() {
        courseTableView.register(UINib(nibName: Const.Xib.Name.firstDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.firstDayTableViewCell)
        courseTableView.register(UINib(nibName: Const.Xib.Name.evenDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.evenDayTableViewCell)
        courseTableView.register(UINib(nibName: Const.Xib.Name.oddDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.oddDayTableViewCell)
    }
    
    private func assignDelegation() {
        courseTableView.delegate = self
        courseTableView.dataSource = self
    }
    
    private func initViewRounding() {
        dayCountLabelBgView.makeRounded(radius: dayCountLabelBgView.frame.height / 2)
    }
    
    func updateData(data: CourseData) {
        self.course = data.course
        
        // view
        courseTitleLabel.text = course.title
        dayCountLabel.text = "\(findCourseProgressDay(challenges: data.course.challenges))일차"
        
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
            return 123
        }
        
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
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
