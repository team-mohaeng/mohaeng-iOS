//
//  CourseViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class CourseViewController: UIViewController {
    
    // MARK: - Properties
    
    var challenges: [Challenge] = [
        Challenge(id: 1, situation: 2, challengeDescription: "알콜스왑으로 핸드폰 닦기", year: "2021", month: "06", day: "27", currentStamp: 3, totalStamp: 3, userMents: ["알콜스왑으로 핸드폰 닦기"]),
        Challenge(id: 1, situation: 2, challengeDescription: "알콜스왑으로 핸드폰 닦기", year: "2021", month: "06", day: "27", currentStamp: 3, totalStamp: 3, userMents: ["알콜스왑으로 핸드폰 닦기"]),
        Challenge(id: 1, situation: 2, challengeDescription: "알콜스왑으로 핸드폰 닦기", year: "2021", month: "06", day: "27", currentStamp: 3, totalStamp: 3, userMents: ["알콜스왑으로 핸드폰 닦기"]),
        Challenge(id: 1, situation: 1, challengeDescription: "알콜스왑으로 핸드폰 닦기", year: "2021", month: "06", day: "27", currentStamp: 3, totalStamp: 3, userMents: ["알콜스왑으로 핸드폰 닦기"]),
        Challenge(id: 1, situation: 0, challengeDescription: "알콜스왑으로 핸드폰 닦기", year: "2021", month: "06", day: "27", currentStamp: 3, totalStamp: 3, userMents: ["알콜스왑으로 핸드폰 닦기"]),
        Challenge(id: 1, situation: 0, challengeDescription: "알콜스왑으로 핸드폰 닦기", year: "2021", month: "06", day: "27", currentStamp: 3, totalStamp: 3, userMents: ["알콜스왑으로 핸드폰 닦기"]),
        Challenge(id: 1, situation: 0, challengeDescription: "알콜스왑으로 핸드폰 닦기", year: "2021", month: "06", day: "27", currentStamp: 3, totalStamp: 3, userMents: ["알콜스왑으로 핸드폰 닦기"]),
    ]
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var courseImageVIew: UIImageView!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var dayCountLabelBgView: UIView!
    @IBOutlet weak var dayLabelBgView: UILabel!
    @IBOutlet weak var courseTableView: UITableView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        registerXib()
        assignDelegation()
        initViewRounding()
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
        return challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = courseTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.firstDayTableViewCell) as? FirstDayTableViewCell {
                
                cell.setCell(challenge: challenges[indexPath.row])
                cell.setNextSituation(next: challenges[indexPath.row + 1].situation)
                
                return cell
            }
            return UITableViewCell()
        }
        
        if indexPath.row % 2 == 1 {
            // 짝수일차
            if let cell = courseTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.evenDayTableViewCell) as? EvenDayTableViewCell {
                
                cell.setCell(challenge: challenges[indexPath.row])
                
                if indexPath.row < challenges.count-1 {
                    cell.setNextSituation(next: challenges[indexPath.row + 1].situation)
                }
                
                return cell
            }
            return UITableViewCell()
        } else {
            // 홀수일차
            if let cell = courseTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.oddDayTableViewCell) as? OddDayTableViewCell {
                
                cell.setCell(challenge: challenges[indexPath.row])
                
                if indexPath.row < challenges.count-1 {
                    cell.setNextSituation(next: challenges[indexPath.row + 1].situation)
                }
                
                return cell
            }
            return UITableViewCell()
        }
    }
    
}
