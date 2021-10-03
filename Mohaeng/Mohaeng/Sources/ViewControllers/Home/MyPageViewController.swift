//
//  MyPageViewController.swift
//  Mohaeng
//
//  Created by 초이 on 2021/09/16.
//

import UIKit
import JTAppleCalendar
import SwiftUI

class MyPageViewController: UIViewController {
    
    // 더미데이터
    var myPageData = MyPage(nickname: "초이초잉", level: 7, email: "choyi@apple.com", characterType: 1, characterImage: "이미지", completeCourseCount: 6, completeChallengeCount: 28, postCount: 1, badgeCount: 20, calendar: [
        MyPageCalendar(property: 0, date: ["2021-08-02"]),
        MyPageCalendar(property: 0, date: ["2021-08-04", "2021-08-05", "2021-08-06", "2021-08-07"]),
        MyPageCalendar(property: 2, date: ["2021-08-09", "2021-08-10", "2021-08-11", "2021-08-12", "2021-08-13", "2021-08-14", "2021-08-15"]),
        MyPageCalendar(property: 3, date: ["2021-08-22"]),
        MyPageCalendar(property: 6, date: ["2021-08-24", "2021-08-25", "2021-08-26", "2021-08-27"])
    ])
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var calendarCollectionView: JTACMonthView!
    @IBOutlet weak var bgCircleView: UIView!
    @IBOutlet weak var shadowStackView: UIStackView!
    @IBOutlet weak var summaryStackView: UIStackView!
    @IBOutlet weak var calendarShadowView: UIView!
    @IBOutlet weak var calendarBgView: UIView!
    
    // MARK: - Properties
    
    let formatter = DateFormatter()
    var frameDimensions: CGFloat = 0.00
    var selected = Date()
    var rangeDates: [[Date]] = []
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initViewRoundingAndShadow()
        initCalendar()
        assignDelegate()
        setRangeDates()
        selectRangeDate()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initTransparentNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
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
            shadowView.addShadowWithOpaqueBackground(opacity: 0.05, radius: 20)
        }
        
        // calendar 뒤 그림자 뷰 rounding, shadow init
        calendarShadowView.makeRounded(radius: 14)
        calendarShadowView.addShadowWithOpaqueBackground(opacity: 0.05, radius: 20)
        
        // calendar bg view rounding
        calendarBgView.makeRounded(radius: 14)
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
        for rangeDate in rangeDates {
            calendarCollectionView.selectDates(rangeDate)
        }
    }
    
    // selectedPosition에 따라 range selection 표시
    func handleCellSelection(view: JTACDayCell?, cellState: CellState) {
        guard let myCustomCell = view as? DateCollectionViewCell else { return }
        
        // dateView background color 찾기
        for (idx, rangeDate) in rangeDates.enumerated() {
            if rangeDate.contains(cellState.date) {
                guard let propertyColor = AppCourse(rawValue: myPageData.calendar[idx].property)?.getBubbleColor() else { return }
                myCustomCell.dateView.backgroundColor = propertyColor
            }
        }
        
        // selectedPosition에 따라 dateView layer rounding
        switch cellState.selectedPosition() {
        case .left:
            myCustomCell.dateView.layer.cornerRadius = myCustomCell.frame.height / 2
            myCustomCell.dateView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .middle:
            myCustomCell.dateView.layer.cornerRadius = 0
            myCustomCell.dateView.layer.maskedCorners = []
        case .right:
            myCustomCell.dateView.layer.cornerRadius = myCustomCell.frame.height / 2
            myCustomCell.dateView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        // full : 한 cell이 left, right, middle 다 차지 할 때 (1cell = 1range)
        case .full:
            myCustomCell.dateView.layer.cornerRadius = myCustomCell.frame.height / 2
            myCustomCell.dateView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        default: break
        }
        
        if !cellState.isSelected { myCustomCell.dateView.backgroundColor = .white }
    }
    
    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? DateCollectionViewCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellSelection(view: cell, cellState: cellState)
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
        
        let startDate = formatter.date(from: "2021 08 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
    
}
