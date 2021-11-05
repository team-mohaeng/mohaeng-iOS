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
    var course: TodayChallengeCourse = TodayChallengeCourse(id: 0, situation: 1, property: 0, title: "", totalDays: 0, currentDay: 0, year: "", month: "", date: "", challenges: [])
    
    var backgroundView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    var headerView: ChallengeStampView?
    
    enum CourseViewUsage: Int {
        case course = 0, history
    }
    
    var courseViewUsage: CourseViewUsage = .course
    
    // 챌린지 인증을 위한 정보
    var courseId: Int?
    var challengeDay: Int?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var courseTableView: UITableView!
    @IBOutlet weak var courseTableViewToTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var selectCourseButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXib()
        assignDelegation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        initNavigationBar()
        
        switch courseViewUsage {
        case .course:
            getCourse()
        case .history:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if courseViewUsage == .course {
            self.initHeaderView()
        } else if courseViewUsage == .history {
            courseTableView.contentInsetAdjustmentBehavior = .never
            hidesBottomBarWhenPushed = true
        }
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        
        if courseViewUsage == .course {
            self.navigationController?.initWithOneCustomButton(
                navigationItem: self.navigationItem,
                firstButtonImage: Const.Image.gnbIcnList,
                firstButtonClosure: #selector(touchLibraryButton(_:)),
                backgroundColor: UIColor.white)
            self.navigationItem.setHidesBackButton(true, animated: true)
        } else if courseViewUsage == .history {
            self.navigationController?.initWithBackButton()
        }
        
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    @objc func touchLibraryButton(_ sender: UIBarButtonItem) {
        let courseLibraryStoryboard = UIStoryboard(name: Const.Storyboard.Name.courseLibrary, bundle: nil)
        guard let courseLibraryViewController = courseLibraryStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.courseLibrary) as? CourseLibraryViewController else {
            return
        }
        self.navigationController?.pushViewController(courseLibraryViewController, animated: true)
    }
    
    private func registerXib() {
        self.headerView = Bundle.main.loadNibNamed(Const.Xib.Name.challengeStampView, owner: self, options: nil)?.last as? ChallengeStampView
        
        courseTableView.register(UINib(nibName: Const.Xib.Name.firstDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.firstDayTableViewCell)
        courseTableView.register(UINib(nibName: Const.Xib.Name.evenDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.evenDayTableViewCell)
        courseTableView.register(UINib(nibName: Const.Xib.Name.oddDayTableViewCell, bundle: nil), forCellReuseIdentifier: Const.Xib.Identifier.oddDayTableViewCell)
        
        courseTableView.register(UINib(nibName: Const.Xib.Name.courseHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Const.Xib.Identifier.courseHeaderView)
        courseTableView.register(UINib(nibName: Const.Xib.Name.courseFooterView, bundle: nil), forHeaderFooterViewReuseIdentifier: Const.Xib.Identifier.courseFooterView)
        
        courseTableView.register(UINib(nibName: Const.Xib.Name.courseHistoryHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Const.Xib.Identifier.courseHistoryHeaderView)
    }
    
    private func assignDelegation() {
        courseTableView.delegate = self
        courseTableView.dataSource = self
        self.headerView?.challengePopUpProtocol = self
    }
    
    private func initHeaderView() {
        let tabBarHeight = tabBarController?.tabBar.bounds.size.height ?? 0
        
        self.courseTableView.tableHeaderView = self.headerView
        self.courseTableView.tableHeaderView?.frame.size.height = UIScreen.main.bounds.height - topbarHeight - tabBarHeight
    }
    
    func updateData(data: TodayChallengeData) {
        self.course = data.course
        
        // header view
        self.headerView?.setData(data: data)
        // table view
        self.courseTableView.reloadData()
        
        // 챌린지 인증을 위한 id
        self.courseId = data.course.id
        self.challengeDay = findTodayChallenge(course: self.course).day
        
    }
    
    func findTodayChallenge(course: TodayChallengeCourse) -> TodayChallenge {
        for (index, item) in course.challenges.enumerated() {
            if item.situation == 1 {
                return item
            } else if item.situation == 0 {
                return course.challenges[index-1]
            }
        }
        // 모든 챌린지가 완료되었을 때
        return course.challenges.last!
    }
    
    func findAndRemoveCircleLayer(_ sublayer: CALayer) {
        if let _ = sublayer as? CAShapeLayer {
            if sublayer.name == "circleLayer" {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    // MARK: - @IBAction Function
    
    @IBAction func touchSelectCourseButton(_ sender: Any) {
        let courseLibraryStoryboard = UIStoryboard(name: Const.Storyboard.Name.courseLibrary, bundle: nil)
        guard let courseLibraryViewController = courseLibraryStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.courseLibrary) as? CourseLibraryViewController else {
            return
        }
        courseLibraryViewController.doingCourse = false
        self.navigationController?.pushViewController(courseLibraryViewController, animated: true)
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
        
        switch courseViewUsage {
        case .course:
            return 132
        case .history:
            return 176
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch courseViewUsage {
        case .course:
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Const.Xib.Identifier.courseHeaderView) as? CourseHeaderView {
                
                let headerBgView: UIView = {
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 132))
                    view.backgroundColor = .white
                    view.makeRoundedSpecificCorner(corners: [.bottomLeft, .bottomRight], cornerRadius: 25)
                    
                    return view
                }()
                
                headerView.backgroundView = headerBgView
                // TODO: - shadow refactoring
                headerView.layer.shadowOpacity = 0.12
                headerView.layer.shadowRadius = 1
                headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
                headerView.layer.shadowColor = UIColor.black.cgColor
                
                headerView.setProperty(by: course.property)
                headerView.setCourseName(name: course.title)
                
                return headerView
            }
        case .history:
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Const.Xib.Identifier.courseHistoryHeaderView) as? CourseHistoryHeaderView {
                
                let headerBgView: UIView = {
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 176))
                    view.backgroundColor = .white
                    view.makeRoundedSpecificCorner(corners: [.bottomLeft, .bottomRight], cornerRadius: 25)
                    
                    return view
                }()
                
                headerView.backgroundView = headerBgView
                // TODO: - shadow refactoring
                headerView.layer.shadowOpacity = 0.12
                headerView.layer.shadowRadius = 1
                headerView.layer.shadowOffset = CGSize(width: 0, height: 2)
                headerView.layer.shadowColor = UIColor.black.cgColor
                
                headerView.setData(by: course)
                headerView.setCourseName(name: course.title)
                
                return headerView
            }
        }
        return UIView()
    }
    
    // section footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Const.Xib.Identifier.courseFooterView) as? CourseFooterView {
            
            if course.challenges.count > 1 {
                if course.challenges[course.challenges.count - 1].situation == 2 {
                    footerView.setIslandImage(isDone: true)
                    footerView.initLastPath(isDone: true, property: course.property)
                    // remove dot
                    for sublayer in footerView.bgView.layer.sublayers! {
                        findAndRemoveCircleLayer(sublayer)
                    }
                } else {
                    footerView.setIslandImage(isDone: false)
                    footerView.initLastPath(isDone: false, property: course.property)
                    // add dot
                    if let challengeDay = challengeDay, challengeDay == course.totalDays {
                        footerView.setDot(property: course.property)
                    }
                }
                footerView.setNextButton(isOnboarding: false)
            }
            
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
                
                cell.setCell(challenge: course.challenges[indexPath.row], property: course.property)
                cell.setNextSituation(next: course.challenges[indexPath.row + 1].situation)
                
                // 진행중인 챌린지일 때 dot 추가
                if let challengeId = challengeDay, challengeId == course.challenges[indexPath.row].day {
                    cell.setDot(property: course.property)
                }
                
                return cell
            }
            return UITableViewCell()
        }
        
        if indexPath.row % 2 == 1 {
            // 짝수일차
            if let cell = courseTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.evenDayTableViewCell) as? EvenDayTableViewCell {
                
                cell.setCell(challenge: course.challenges[indexPath.row], property: course.property)
                
                if indexPath.row < course.challenges.count-1 {
                    cell.setNextSituation(next: course.challenges[indexPath.row + 1].situation)
                }
                // 진행중인 챌린지일 때 dot 추가
                if let challengeId = challengeDay, challengeId == course.challenges[indexPath.row].day {
                    cell.setDot(property: course.property)
                } else {
                    for sublayer in cell.contentView.layer.sublayers! {
                        findAndRemoveCircleLayer(sublayer)
                    }
                }
                return cell
            }
            return UITableViewCell()
        } else {
            // 홀수일차
            if let cell = courseTableView.dequeueReusableCell(withIdentifier: Const.Xib.Identifier.oddDayTableViewCell) as? OddDayTableViewCell {
                
                cell.setCell(challenge: course.challenges[indexPath.row], property: course.property)
                
                if indexPath.row < course.challenges.count-1 {
                    cell.setNextSituation(next: course.challenges[indexPath.row + 1].situation)
                    // 진행중인 챌린지일 때 dot 추가
                    if let challengeId = challengeDay, challengeId == course.challenges[indexPath.row].day {
                        cell.setDot(property: course.property)
                    } else {
                        for sublayer in cell.contentView.layer.sublayers! {
                            findAndRemoveCircleLayer(sublayer)
                        }
                    }
                } else {
                    // 맨 마지막 cell일 때
                    cell.setNextSituation(next: 9)
                }
                return cell
            }
            return UITableViewCell()
        }
    }
}

// MARK: - ChallengePopUpProtocol

extension CourseViewController: ChallengePopUpProtocol {
    
    func touchHelpButton(_ sender: UIButton) {
        let helpPopUp = ChallengeHelpPopUpViewController()
        helpPopUp.modalTransitionStyle = .crossDissolve
        helpPopUp.modalPresentationStyle = .overCurrentContext
        helpPopUp.challengePopUpProtocol = self
        
        tabBarController?.present(helpPopUp, animated: true, completion: nil)
    }
    
    func touchStampButton(_ sender: UITapGestureRecognizer) {
        let completePopUp = ChallengeCompletePopUpViewController()
        completePopUp.modalTransitionStyle = .crossDissolve
        completePopUp.modalPresentationStyle = .overCurrentContext
        completePopUp.popUpUsage = .challenge
        completePopUp.challengePopUpProtocol = self
        
        tabBarController?.present(completePopUp, animated: true, completion: nil)
    }
    
    func pushToFinishViewController() {
        putTodayChallenge { [weak self] response in
            self?.getCourse()
            let viewController = ChallengeRewardViewController()
            viewController.completedChallengeData = response
            
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self?.present(navigationController, animated: true, completion: nil)
                
            }
        }
    }
    
    func pushToNextOnboardingViewController() {}
}

// MARK: - 서버 통신

extension CourseViewController {
    
    func getCourse() {
        
        ChallengeAPI.shared.getAllChallenges { (response) in
            
            switch response {
            case .success(let course):
                if let data = course as? TodayChallengeData {
                    self.emptyView.isHidden = true
                    self.updateData(data: data)
                }
                
            case .requestErr(let message):
                print("requestErr", message)
                if let message = message as? String {
                    if message == "진행 중인 코스가 없습니다." {
                        self.emptyView.isHidden = false
                        self.selectCourseButton.makeRounded(radius: self.selectCourseButton.frame.height / 2)
                    }
                }
                
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func putTodayChallenge(completion: (@escaping(CompletedChallengeData) -> Void)) {
        
        if let courseId = self.courseId, let challengeId = self.challengeDay {
            
            ChallengeAPI.shared.putTodayChallenge(completion: { (response) in
                
                switch response {
                case .success(let completeData):
                    if let data = completeData as? CompletedChallengeData {
                        completion(data)
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
                
            }, courseId: courseId, challengeId: challengeId)
            
        }
        
    }
    
}
