//
//  HappyPopUpViewController.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/10/17.
//

import UIKit

class HappyPopUpViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var happyPercentLabel: UILabel!
    @IBOutlet weak var happyDescription: UILabel!
    @IBOutlet weak var levelDescription: UILabel!
    
    // MARK: - Properties
    
    var data: Home = Home(nickname: "", level: "", happy: 0, fullHappy: 0, characterLottie: "", characterSkin: "", isStyleNew: false, isBadgeNew: false, course: CourseInfo(challengeTitle: "", percent: 0))
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViewRounding()
        initData()
        setLineHeight()
    }
        
    // MARK: - Functions
    
    func initViewRounding() {
        popUpView.makeRounded(radius: 30)
        progressView.makeRounded(radius: 8.5)
    }
    
    func initData() {
        levelLabel.text = "Lv.\(data.level)"
        happyPercentLabel.text = "해피지수  \(data.happy)/\(data.fullHappy) (\(getHappyPercent())%)"
        progressView.setProgress(Float(data.happy) / Float(data.fullHappy), animated: false)
    }
    
    func setLineHeight() {
        happyDescription.setLineHeight(lineHeight: 18)
        levelDescription.setLineHeight(lineHeight: 18)
    }
    
    func getHappyPercent() -> Int {
        return Int(Float(data.happy) / Float(data.fullHappy) * 100)
    }

    // MARK: - @IBAction Functions
    
    @IBAction func dismissSelf(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
