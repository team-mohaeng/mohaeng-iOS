//
//  MoodViewController.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/07.
//

import UIKit

class MoodViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var sosoDayButton: UIButton!
    @IBOutlet weak var fineDayButton: UIButton!
    @IBOutlet weak var goodDayButton: UIButton!
    @IBOutlet weak var sosoDayLabel: UILabel!
    @IBOutlet weak var findDayLabel: UILabel!
    @IBOutlet weak var goodDayLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    var moodStatus: Int = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initNavigationBar()
        initCurruentDay()
        makeNextButtonDisable()
        makeNextButtonRound()
    }
    
    // MARK: - Functions
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        navigationItem.title = "소확행 작성하기"
    }
    
    private func initCurruentDay() {
        var currentDay = AppDate()
        dateLabel.text = "\(currentDay.getYear()).\(currentDay.getMonth()).\(currentDay.getDay()) (\(currentDay.getWeekday().toSimpleKorean()))"
    }
    
    private func makeNextButtonDisable() {
        nextButton.isEnabled = false
    }
    
    private func makeNextButtonRound() {
        nextButton.makeRounded(radius: nextButton.frame.height / 2)
    }
    
    private func setOpacityLow(button: UIButton, label: UILabel) {
        button.alpha = 0.1
        label.alpha = 0.1
    }
    
    private func setOpacityHigh(button: UIButton, label: UILabel) {
        button.alpha = 1.0
        label.alpha = 1.0
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchSosoDayButton(_ sender: Any) {
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
        
        sosoDayButton.setImage(Const.Image.imgFaceGraphic1circle, for: .normal)
        fineDayButton.setImage(Const.Image.imgFaceGraphicIn1, for: .normal)
        goodDayButton.setImage(Const.Image.imgFaceGraphicIn3, for: .normal)
        
        setOpacityHigh(button: sosoDayButton, label: sosoDayLabel)
        setOpacityLow(button: fineDayButton, label: findDayLabel)
        setOpacityLow(button: goodDayButton, label: goodDayLabel)
        
        moodStatus = 0
    }
    
    @IBAction func touchFineDayButton(_ sender: Any) {
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
        
        sosoDayButton.setImage(Const.Image.imgFaceGraphicIn2, for: .normal)
        fineDayButton.setImage(Const.Image.imgFaceGraphic2circle, for: .normal)
        goodDayButton.setImage(Const.Image.imgFaceGraphicIn3, for: .normal)
        
        setOpacityHigh(button: fineDayButton, label: findDayLabel)
        setOpacityLow(button: sosoDayButton, label: sosoDayLabel)
        setOpacityLow(button: goodDayButton, label: goodDayLabel)
        
        moodStatus = 1
    }
    
    @IBAction func touchGoodDayButton(_ sender: Any) {
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
        
        sosoDayButton.setImage(Const.Image.imgFaceGraphicIn2, for: .normal)
        fineDayButton.setImage(Const.Image.imgFaceGraphicIn1, for: .normal)
        goodDayButton.setImage(Const.Image.imgFaceGraphic3circle, for: .normal)
        
        setOpacityHigh(button: goodDayButton, label: goodDayLabel)
        setOpacityLow(button: fineDayButton, label: findDayLabel)
        setOpacityLow(button: sosoDayButton, label: sosoDayLabel)
        
        moodStatus = 2
    }
    
    @IBAction func touchNextButton(_ sender: Any) {
        let writingStoryboard = UIStoryboard(name: Const.Storyboard.Name.writing, bundle: nil)
        guard let writingViewController = writingStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.writing) as? WritingViewController else { return }
        
        writingViewController.moodStatus = moodStatus
        
        self.navigationController?.pushViewController(writingViewController, animated: true)
    }
    
}
