//
//  YearPickerViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/11.
//

import UIKit

protocol YearPickerViewDelegate: class {
    func passData(_ year: String)
}

class YearPickerViewController: UIViewController {
    
    // MARK: - Properties
    
    var year: Int? = 0
  
    var yearList: [String] = []
    
    let currentYear = AppYear()
    
    weak var yearPickerDataDelegate: YearPickerViewDelegate?
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var yearPickerView: UIPickerView!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPickerViewInitialDate()
        setDelegation()
        makeButtonRound()
        initDateData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.yearPickerView.subviews[1].backgroundColor = UIColor.clear
        }
        nextButton.isEnabled = false
        nextButton.backgroundColor = UIColor.CourseBgGray
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func closeModalButton(_ sender: Any) {
        dismissDatePicker()
    }
    @IBAction func closePickerViewButton(_ sender: Any) {
        guard let year = self.year else {
            return
        }
        print(year)
        self.yearPickerDataDelegate?.passData("\(year)")
        dismissDatePicker()
        
    }
    
    // MARK: - function
    
    func setPickerViewInitialDate() {
        guard let unwrappedYear = self.year else {
            return
        }
        
        self.yearPickerView.selectRow(unwrappedYear, inComponent: 0, animated: true)
    }
    
    private func makeButtonRound() {
        nextButton.makeRounded(radius: 24)
    }

    private func setDelegation() {
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
    }
    
    private func initDateData() {
        yearList = (1979...currentYear.getYear()).map({String($0)})
    }
    
    private func dismissDatePicker() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func updateMonthData(_ selectedYear: Int) {
        self.year = selectedYear
    }
  
}

// MARK: - Extensions

// MARK: - UIPickerViewDelegate

extension YearPickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
            return NSAttributedString(string: yearList[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nextButton.isEnabled = true
        nextButton.backgroundColor = UIColor.Pink
        guard let unwrappedYear = Int(yearList[row]) else {
            return
        }
        updateMonthData(unwrappedYear)
    }
}

// MARK: - UIPickerViewDataSource

extension YearPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearList.count
        
    }
    
}
