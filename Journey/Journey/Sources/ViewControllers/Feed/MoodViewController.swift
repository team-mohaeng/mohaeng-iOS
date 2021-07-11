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
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initNavigationBar()
        makeNextButtonDisable()
        makeNextButtonRound()
    }
    
    // MARK: - Functions
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        navigationItem.title = "소확행 작성하기"
    }
    
    private func makeNextButtonDisable() {
        nextButton.isEnabled = false
    }
    
    private func makeNextButtonRound() {
        nextButton.makeRounded(radius: nextButton.frame.height / 2)
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchSosoDayButton(_ sender: Any) {
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
        
        sosoDayButton.setImage(UIImage(named: "sampleMoodImg"), for: .normal)
        fineDayButton.setImage(UIImage(named: "sampleMoodUnselectedImg"), for: .normal)
        goodDayButton.setImage(UIImage(named: "sampleMoodUnselectedImg"), for: .normal)
    }
    
    @IBAction func touchFineDayButton(_ sender: Any) {
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
        
        sosoDayButton.setImage(UIImage(named: "sampleMoodUnselectedImg"), for: .normal)
        fineDayButton.setImage(UIImage(named: "sampleMoodImg"), for: .normal)
        goodDayButton.setImage(UIImage(named: "sampleMoodUnselectedImg"), for: .normal)
    }
    
    @IBAction func touchGoodDayButton(_ sender: Any) {
        nextButton.isEnabled = true
        nextButton.alpha = 1.0
        
        sosoDayButton.setImage(UIImage(named: "sampleMoodUnselectedImg"), for: .normal)
        fineDayButton.setImage(UIImage(named: "sampleMoodUnselectedImg"), for: .normal)
        goodDayButton.setImage(UIImage(named: "sampleMoodImg"), for: .normal)
    }
    
    @IBAction func touchNextButton(_ sender: Any) {
        let writingStoryboard = UIStoryboard(name: Const.Storyboard.Name.writing, bundle: nil)
        guard let nextVC = writingStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.writing) as? WritingViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
