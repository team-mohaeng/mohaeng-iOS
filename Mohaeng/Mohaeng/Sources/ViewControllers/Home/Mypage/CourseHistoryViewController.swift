//
//  CourseHistoryViewController.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/12.
//

import UIKit

class CourseHistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    var courseHistory = CourseHistoryData(courses: [])
    var startNewCoursePopUp = PopUpViewController()
    var selectedCourseId: Int?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var courseHistoryCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        setDelegation()
        registerXib()
        getCourseHistory()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
        self.navigationItem.title = "챌린지 기록보기"
    }
    
    private func setDelegation() {
        courseHistoryCollectionView.delegate = self
        courseHistoryCollectionView.dataSource = self
    }
    
    private func registerXib() {
        courseHistoryCollectionView.register(UINib(nibName: Const.Xib.Name.courseHistoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.courseHistoryCollectionViewCell)
    }
    
    private func updateData(courses: CourseHistoryData) {
        self.courseHistory = courses
        self.courseHistoryCollectionView.reloadData()
    }
    
    private func mapDataToTodayChallengeCourse(courseHistory: CourseHistory) -> TodayChallengeCourse {
        var course = TodayChallengeCourse(
            id: courseHistory.id,
            situation: courseHistory.situation,
            property: courseHistory.property,
            title: courseHistory.title,
            totalDays: courseHistory.totalDays,
            currentDay: courseHistory.totalDays,
            year: courseHistory.year,
            month: courseHistory.month,
            date: courseHistory.date,
            challenges: [])
        
        for challenge in courseHistory.challenges {
            
            let todayChallenge = TodayChallenge(
                day: challenge.day,
                situation: challenge.situation,
                title: challenge.title,
                happy: 0,
                beforeMent: "",
                afterMent: "",
                year: challenge.year,
                month: challenge.month,
                date: challenge.date,
                badges: [])
            
            course.challenges.append(todayChallenge)
        }
        
        return course
    }
    
    // MARK: - @IBAction Functions

}

// MARK: - UICollectionViewDelegateFlowLayout

extension CourseHistoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 50, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let courseStoryboard = UIStoryboard(name: Const.Storyboard.Name.course, bundle: nil)
        guard let courseViewController = courseStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.course) as? CourseViewController else {
            return
        }
        courseViewController.courseViewUsage = .history
        courseViewController.course = mapDataToTodayChallengeCourse(courseHistory: courseHistory.courses[indexPath.row])
        
        self.navigationController?.pushViewController(courseViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension CourseHistoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseHistory.courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.courseHistoryCollectionViewCell, for: indexPath) as? CourseHistoryCollectionViewCell {
            
            cell.setCell(course: courseHistory.courses[indexPath.row])
            cell.coursePopUpProtocol = self
            
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - CoursePopUpProtocol

extension CourseHistoryViewController: CoursePopUpProtocol {
    func touchStartNewCourseButton(_ sender: UIButton, courseId: Int) {
        
        selectedCourseId = courseId
        
        startNewCoursePopUp = PopUpViewController(nibName: Const.Xib.Name.popUp, bundle: nil)
        startNewCoursePopUp.modalPresentationStyle = .overCurrentContext
        startNewCoursePopUp.modalTransitionStyle = .crossDissolve
        startNewCoursePopUp.popUpUsage = .twoButtonWithImage
        startNewCoursePopUp.setText(title: "안녕하세요타이틀", description: "이런부분은나중에strings파일만들어서관리하려고합니다어떤가용?")
        startNewCoursePopUp.popUpActionDelegate = self
        tabBarController?.present(startNewCoursePopUp, animated: true, completion: nil)
        
    }
}

// MARK: - PopUpActionDelegate

extension CourseHistoryViewController: PopUpActionDelegate {
    func touchGreyButton(button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func touchYellowButton(button: UIButton) {
        print("yellow")
    }
}

// MARK: - 통신

extension CourseHistoryViewController {
    func getCourseHistory() {
        
        CourseHistoryAPI.shared.getCourseHistory { (response) in
            
            switch response {
            case .success(let courses):
                
                if let data = courses as? CourseHistoryData {
                    self.updateData(courses: data)
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
