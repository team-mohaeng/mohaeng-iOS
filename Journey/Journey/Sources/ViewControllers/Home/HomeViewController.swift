//
//  HomeViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var courseTitleButton: UIButton!
    @IBOutlet weak var courseDayBoxView: UIView!
    @IBOutlet weak var courseDayLabel: UILabel!
    @IBOutlet weak var densityProgressView: UIProgressView!
    @IBOutlet weak var percentDescriptionButton: UIButton!
    @IBOutlet weak var firstIndicatiorLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdIndicatorLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var densityPercentLabel: UILabel!
    
    // MARK: - Properties
    var densityPercent: CGFloat = 0.5
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initAttributes()
        initProgressView()
        setDensityPercent()
        setIndicatorPosition()
    }
    
    // MARK: - @IBAction Functions
    
    @objc func touchAwardButton(sender: UIButton) {
        let medalStoryboard = UIStoryboard(name: Const.Storyboard.Name.medal, bundle: nil)
        guard let medalViewController = medalStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.medal) as? MedalViewController else {
            return
        }
        self.navigationController?.pushViewController(medalViewController, animated: true)
    }
    
    @objc func touchSettingButton(sender: UIButton) {
        
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        let awardItem = initNavigationIconWithSpacing(name: "tempImg", buttonEvent: #selector(touchAwardButton(sender:)))
        let settingItem = initNavigationIconWithSpacing(name: "tempImg", buttonEvent: #selector(touchSettingButton(sender:)))
        
        self.navigationItem.rightBarButtonItems = [settingItem, awardItem]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.initNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
    }
    
    private func initNavigationIconWithSpacing(name: String, buttonEvent: Selector) -> UIBarButtonItem {
        let button: UIButton = UIButton.init(type: .custom)
        button.setImage(UIImage(named: name), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.addTarget(self, action: buttonEvent, for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        
        return item
    }
    
    private func initAttributes() {
        courseDayBoxView.layer.cornerRadius = 16
        courseDayBoxView.clipsToBounds = true
        
        percentDescriptionButton.layer.cornerRadius = percentDescriptionButton.frame.width / 2
        
        courseTitleButton.contentEdgeInsets = UIEdgeInsets(top: 0.01, left: 0, bottom: 0.01, right: 0)
    }
    
    private func initProgressView() {
        let indicatorWidth = 8 / (UIScreen.main.bounds.width - 48)
        densityProgressView.makeRounded(radius: 7)
        densityProgressView.layer.sublayers![1].cornerRadius = 7
        densityProgressView.subviews[1].clipsToBounds = true
        densityProgressView.progress = Float(densityPercent + indicatorWidth)
    }
    
    private func setIndicatorPosition() {
        let progressViewWidth = (UIScreen.main.bounds.width - 48)
        firstIndicatiorLeadingConstraint.constant = progressViewWidth / 4
        thirdIndicatorLeadingConstraint.constant = progressViewWidth * 3 / 4
    }
    
    private func setDensityPercent() {
        print(densityPercent)
        densityPercentLabel.text = "\(Int(densityPercent * 100))%"
        
    }
}
