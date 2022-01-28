//
//  MyPageViewController.swift
//  Mohaeng
//
//  Created by 초이 on 2021/09/16.
//

import UIKit
import JTAppleCalendar

class MyPageViewController: UIViewController {
    
    // 더미데이터
    var myPageData = MyPage(nickname: "", email: "", completeCourseCount: 0, completeChallengeCount: 0, feedCount: 0, badgeCount: 0, calendar: [
        MyPageCalendar(property: 1, date: [])
    ])
    let currentDate = AppDate()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var calendarCollectionView: JTACMonthView!
    @IBOutlet weak var calendarLeftButton: UIButton!
    @IBOutlet weak var calendarRightButton: UIButton!
    @IBOutlet weak var bgCircleView: UIView!
    @IBOutlet weak var shadowStackView: UIStackView!
    @IBOutlet weak var summaryStackView: UIStackView!
    @IBOutlet weak var calendarShadowView: UIView!
    @IBOutlet weak var calendarBgView: UIView!
    @IBOutlet weak var yearMonthLabel: UILabel!
    @IBOutlet weak var courseHistoryButtonView: UIView!
    @IBOutlet weak var courseHistoryShadowView: UIView!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var completeCourseCountLabel: UILabel!
    @IBOutlet weak var completeChallengeCountLabel: UILabel!
    @IBOutlet weak var feedCountLabel: UILabel!
    @IBOutlet weak var badgeCountLabel: UILabel!
    
    // MARK: - Properties
    
    let formatter = DateFormatter()
    var frameDimensions: CGFloat = 0.00
    var selected = Date()
    var rangeDates = [[Date]]()
    var totalSectionCount: Int = 0
    var currentSection: Int = 0 {
        didSet {
            hideArrowButton()
        }
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewRoundingAndShadow()
        initCalendar()
        assignDelegate()
        setRangeDates()
        selectRangeDate()
        setTotalSectionCount()
        addTapGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initNavigationBar()
        getMyPage()
    }

    // MARK: - @IBAction Functions
    
    @IBAction func touchLeftArrowButton(_ sender: Any) {
        touchArrowButton(isLeft: true)
    }
    
    @IBAction func touchRightArrowButton(_ sender: Any) {
        touchArrowButton(isLeft: false)
    }
    @IBAction func touchEditNicknameButton(_ sender: UIButton) {
        pushNickNameEditViewController()
    }
    
    @objc func touchCourseHistoryButton(_ sender: Any) {
        let courseHistoryStoryboard = UIStoryboard(name: Const.Storyboard.Name.courseHistory, bundle: nil)
        guard let courseHistoryViewController = courseHistoryStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.courseHistory) as? CourseHistoryViewController else {
            return
        }
        self.navigationController?.pushViewController(courseHistoryViewController, animated: true)
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithOneCustomButton(
            navigationItem: self.navigationItem,
            firstButtonImage: Const.Image.settingIcn,
            firstButtonClosure: #selector(touchSettingButton(_:)))
    }
    
    @objc func touchSettingButton(_ sender: UIBarButtonItem) {
        let settingStoryboard = UIStoryboard(name: Const.Storyboard.Name.setting, bundle: nil)
        guard let settingViewController = settingStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.setting) as? SettingViewController else {
            return
        }
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    private func initViewRoundingAndShadow() {
        // 배경 노란색 원
        bgCircleView.makeRounded(radius: self.bgCircleView.frame.height / 2)
        
        // 요약 뷰 rounding
        for summaryView in summaryStackView.subviews {
            summaryView.makeRounded(radius: 14)
        }
        
        // 요약 뷰 뒤 그림자 뷰 rounding, shadow init
        for shadowView in shadowStackView.subviews {
            shadowView.makeRounded(radius: 14)
            shadowView.addShadowWithOpaqueBackground(opacity: 0.1, radius: 14)
        }
        
        // calendar 뒤 그림자 뷰 rounding, shadow init
        calendarShadowView.makeRounded(radius: 14)
        calendarShadowView.addShadowWithOpaqueBackground(opacity: 0.1, radius: 14)
        
        // calendar bg view rounding
        calendarBgView.makeRounded(radius: 14)
        
        // 챌린지 기록 보기 버튼 뷰
        courseHistoryButtonView.makeRounded(radius: 14)
        courseHistoryShadowView.makeRounded(radius: 14)
        courseHistoryShadowView.addShadowWithOpaqueBackground(opacity: 0.1, radius: 14)
        
    }
    
    private func assignDelegate() {
        calendarCollectionView.ibCalendarDelegate = self
        calendarCollectionView.ibCalendarDataSource = self
    }
    
    private func initCalendar() {
        // date cell 간 간격
        calendarCollectionView.minimumLineSpacing = 5
        calendarCollectionView.minimumInteritemSpacing = 0
        
        // multiple selection, range 설정
        calendarCollectionView.allowsMultipleSelection = true
        calendarCollectionView.allowsRangedSelection = true
        
        // range selection시 cell 사이 1px짜리 vertical line 없애기 위해 cell size 지정
        // TODO: - UICollectionView issue: recurring decimal value 수정해야 함 지금은 임시방편
        calendarCollectionView.cellSize = ((self.view.frame.width - 48) / 7).rounded()
        frameDimensions = (self.view.frame.width - 48) / 7
    }
    
    private func setRangeDates() {
        self.rangeDates.removeAll()
        
        guard let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian) else { return }
        for dateRange in myPageData.calendar {
            var rangeDate: [Date] = []
            for date in dateRange.date {
                let dateArray = date.split(separator: "-").map { Int(String($0)) }
                let dateComponent = DateComponents(year: dateArray[0], month: dateArray[1], day: dateArray[2])
                let date = gregorianCalendar.date(from: dateComponent as DateComponents)!
                rangeDate.append(date)
            }
            self.rangeDates.append(rangeDate)
        }
    }
    
    private func selectRangeDate() {
        calendarCollectionView.deselectAllDates()
        for rangeDate in rangeDates {
            calendarCollectionView.selectDates(rangeDate)
        }
    }
    
    // selectedPosition에 따라 range selection 표시
    func handleCellSelection(cell: JTACDayCell?, cellState: CellState) {
        guard let cell = cell as? DateCollectionViewCell else { return }
        
        // dateView background color 찾기
        for (idx, rangeDate) in rangeDates.enumerated() {
            if rangeDate.contains(cellState.date) {
                guard let propertyColor = AppCourse(rawValue: myPageData.calendar[idx].property)?.getBubbleColor() else { return }
                cell.dateView.backgroundColor = propertyColor
            }
        }
        
        // selectedPosition에 따라 dateView layer rounding
        switch cellState.selectedPosition() {
        case .left:
            cell.dateView.layer.cornerRadius = cell.frame.height / 2
            cell.dateView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .middle:
            cell.dateView.layer.cornerRadius = 0
            cell.dateView.layer.maskedCorners = []
        case .right:
            cell.dateView.layer.cornerRadius = cell.frame.height / 2
            cell.dateView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        // full : 한 cell이 left, right, middle 다 차지 할 때 (1cell = 1range)
        case .full:
            cell.dateView.layer.cornerRadius = cell.frame.height / 2
            cell.dateView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        default: break
        }
        
        if !cellState.isSelected { cell.dateView.backgroundColor = .white }
    }
    
    func handleCellText(cell: JTACDayCell?, cellState: CellState) {
        
        guard let cell = cell as? DateCollectionViewCell else { return }
        
        cell.dateLabel.text = cellState.text
        
        if cellState.dateBelongsTo == .thisMonth {
            cell.isHidden = false
            cell.dateLabel.textColor = .black
        } else {
            cell.isHidden = true
        }
        
    }
    
    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? DateCollectionViewCell  else { return }
        handleCellSelection(cell: cell, cellState: cellState)
        handleCellText(cell: cell, cellState: cellState)
    }
  
    func touchArrowButton(isLeft: Bool) {
        if isLeft {
            let section = currentSection - 1 < 0 ? 0 : currentSection - 1
            currentSection = section
            
            calendarCollectionView.scrollToItem(at: IndexPath.init(row: 0, section: currentSection), at: .left, animated: true)
        } else {
            let section = currentSection + 1 > totalSectionCount ? currentSection : currentSection + 1
            currentSection = section
                
            calendarCollectionView.scrollToItem(at: IndexPath.init(row: 0, section: currentSection), at: .left, animated: true)
        }
        
        let startYear = 2021
        let selectedYear = (currentSection / 12) + startYear
        let selectedMonth = (1 + currentSection) % 12
        yearMonthLabel.text = "\(selectedYear)년 \(selectedMonth == 0 ? 12 : selectedMonth)월"
    }
    
    func setTotalSectionCount() {
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2021 01 01")!
        
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: Date())
        let components = calendar.dateComponents([.month], from: start, to: end)
        
        totalSectionCount = components.month ?? 1
    }
    
    func scrollToCurrentMonth() {
        currentSection = totalSectionCount
        calendarCollectionView.scrollToItem(at: IndexPath.init(row: 0, section: currentSection), at: .left, animated: true)
        
        let currentMonth = (totalSectionCount + 1) % 12
        yearMonthLabel.text = "\(currentDate.getYear())년 \(currentMonth)월"
    }
    
    // 2021년 1월 / 현재년월 캘린더일때 왼쪽, 오른쪽 버튼 숨김 처리
    func hideArrowButton() {
        calendarLeftButton.isHidden = currentSection == 0
        calendarRightButton.isHidden = currentSection == totalSectionCount
    }
    
    // 통신 후 data 업데이트
    func updateData(data: MyPage) {
        
        self.myPageData = data
        
        nicknameLabel.text = data.nickname
        emailLabel.text = data.email
        
        completeCourseCountLabel.text = String(data.completeCourseCount)
        completeChallengeCountLabel.text = String(data.completeChallengeCount)
        feedCountLabel.text = String(data.feedCount)
        badgeCountLabel.text = String(data.badgeCount)
        
        setTotalSectionCount()
        setRangeDates()
        selectRangeDate()
        scrollToCurrentMonth()
    }
    
    private func addTapGestureRecognizer() {
        let courseHistoryGesture = UITapGestureRecognizer(target: self, action: #selector(touchCourseHistoryButton(_:)))
        courseHistoryButtonView.addGestureRecognizer(courseHistoryGesture)
    }
    
    private func pushNickNameEditViewController() {
        let signUpThirdStoryboard = UIStoryboard(name: Const.Storyboard.Name.signUpThird, bundle: nil)
        guard let signUpThirdViewController = signUpThirdStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.signUpThird) as?
                SignUpThirdViewController else {
                    return
                }
        signUpThirdViewController.nicknameUsage = .myPage
        signUpThirdViewController.placeholder = nicknameLabel.text
        self.navigationController?.pushViewController(signUpThirdViewController, animated: true)
    }
}

// MARK: - JTACMonthViewDelegate
extension MyPageViewController: JTACMonthViewDelegate {
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: Const.Xib.Identifier.dateCell, for: indexPath) as? DateCollectionViewCell else {
            return JTACDayCell()
        }
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
}

// MARK: - JTACMonthViewDataSource
extension MyPageViewController: JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2021 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
    
}

// MARK: - 통신

extension MyPageViewController {
    func getMyPage() {
            
            MyPageAPI.shared.getMyPage { (response) in
                
                switch response {
                case .success(let data):
                    
                    if let data = data as? MyPage {
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
