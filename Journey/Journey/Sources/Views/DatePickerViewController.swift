//
//  DatePickerViewController.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/06.
//

import UIKit

protocol DatePickerViewDelegate: AnyObject {
    func passData(_ year: String, _ month: String)
}

class DatePickerViewController: UIViewController {

    // MARK: - Properties
    
    var year: Int? = 0
    var month: Int? = 0
    
    var yearList: [String] = []
    var monthList: [String] = []
    
    var currentMonthList: [String] = []
    var currentDayList: [String] = []
    let currentDate = AppDate()
    weak var datePickerDataDelegate: DatePickerViewDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var yearPickerView: UIPickerView!
    @IBOutlet weak var monthPickerView: UIPickerView!
    @IBOutlet weak var applyButton: UIButton!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegation()
        initDateData()
        initAttribute()
        setPickerViewInitialDate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.yearPickerView.subviews[1].backgroundColor = UIColor.clear
            self.monthPickerView.subviews[1].backgroundColor = UIColor.clear
        }
    }
    
    // MARK: - function
    
    private func setPickerViewInitialDate() {
        guard let unwrappedYear = self.year,
              let unwrappedMonth = self.month else {
            return
        }
        self.yearPickerView.selectRow(unwrappedYear - 2000, inComponent: 0, animated: true)
        self.monthPickerView.selectRow(unwrappedMonth - 1, inComponent: 0, animated: true)
    }
    
    private func setDelegation() {
        monthPickerView.delegate = self
        yearPickerView.delegate = self

        monthPickerView.dataSource = self
        yearPickerView.dataSource = self
    }
    
    private func initDateData() {
        yearList = (2000...currentDate.getYear()).map({String($0)})
        monthList = (1...12).map({String($0)})
        currentMonthList = (1...currentDate.getMonth()).map({String($0)})
    }
    
    private func initAttribute() {
        applyButton.makeRounded(radius: applyButton.frame.height / 2)
    }
    
    private func updateMonthData(_ selectedYear: Int) {
        if self.year != currentDate.getYear() && selectedYear == currentDate.getYear() {
            self.year = selectedYear
            guard let unwrappedMonth = self.month else { return }
            if unwrappedMonth > self.currentDate.getMonth() {
                self.month = self.currentDate.getMonth()
            }
            self.monthPickerView.reloadComponent(0)
        } else if self.year == currentDate.getYear() && selectedYear != currentDate.getYear() {
            self.year = selectedYear
            self.monthPickerView.reloadComponent(0)
        } else {
            self.year = selectedYear
        }
    }
    
    private func dismissDatePicker() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    
    @IBAction func touchCloseButton(_ sender: Any) {
        dismissDatePicker()
    }
    
    @IBAction func touchApplyButton(_ sender: Any) {
        guard let unwrappedYear = self.year,
              let unwrappedMonth = self.month else {
            return
        }
        
        self.datePickerDataDelegate?.passData("\(unwrappedYear)", "\(unwrappedMonth)")
        dismissDatePicker()
    }
}

extension DatePickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if pickerView == self.yearPickerView {
            return NSAttributedString(string: yearList[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        } else {
            return NSAttributedString(string: monthList[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case self.yearPickerView:
            guard let unwrappedYear = Int(yearList[row]) else {
                return
            }
            updateMonthData(unwrappedYear)
        case self.monthPickerView:
            guard let unwrappedMonth = Int(monthList[row]) else {
                return
            }
            month = unwrappedMonth
        default:
            break
        }
    }

}

extension DatePickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.yearPickerView {
            return yearList.count
        } else {
            if year == currentDate.getYear() {
                return currentMonthList.count
            }
            return monthList.count
        }
    }
}
