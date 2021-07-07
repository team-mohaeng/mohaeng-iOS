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
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initAttributes()
        initProgressView()
    }
    
    // MARK: - @IBAction Functions
    
    @objc func touchAwardButton(sender: UIButton) {
        let medalStoryboard = UIStoryboard(name: Const.Storyboard.Name.medal, bundle: nil)
        guard let medalViewController = medalStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.medal) as? MedalViewController else {
            return
        }
        self.navigationController?.pushViewController(medalViewController, animated: true)
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        let awardItem = initNavigationIconWithSpacing(name: "awardIcon")
        let chatItem = initNavigationIconWithSpacing(name: "messageIcon")
        let settingItem = initNavigationIconWithSpacing(name: "settingsIcon")
        
        self.navigationItem.rightBarButtonItems = [settingItem, chatItem, awardItem]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.initNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
    }
    
    private func initNavigationIconWithSpacing(name: String) -> UIBarButtonItem {
        let button: UIButton = UIButton.init(type: .custom)
        button.setImage(UIImage(named: name), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.addTarget(self, action: #selector(touchAwardButton(sender:)), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        
        return item
    }
    
    private func initAttributes() {
        courseDayBoxView.layer.cornerRadius = 16
        courseDayBoxView.clipsToBounds = true
        
        percentDescriptionButton.layer.cornerRadius = percentDescriptionButton.frame.width / 2
        
    }
    
    private func initProgressView() {
        densityProgressView.progressViewStyle = .default
        densityProgressView.layer.cornerRadius = 5
        densityProgressView.clipsToBounds = true
        densityProgressView.layer.sublayers![1].cornerRadius = 0
        densityProgressView.subviews[1].clipsToBounds = true
        densityProgressView.progress = 0.75
    }
}
