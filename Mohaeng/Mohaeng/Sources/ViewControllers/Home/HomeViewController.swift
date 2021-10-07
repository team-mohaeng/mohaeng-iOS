//
//  HomeViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var challengInfoView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var customCharaterButtonView: UIView!
    @IBOutlet weak var hourlyMentLabel: UILabel!
    @IBOutlet weak var challengeInfoShadowView: UIView!
    @IBOutlet weak var progressShadowView: UIView!
    @IBOutlet weak var customCharaterShadowView: UIView!
    
    // MARK: - Properties
    
    private var rewardButton: UIBarButtonItem!
    private var chattingButton: UIBarButtonItem!
    private var mypageButton: UIBarButtonItem!
    private var morningText: String = "아라아라! 아침이야!\n오늘 하루도 화이팅"
    private var nightText: String = "아라아라! 벌써 밤이야!\n인증하고 일찍자자"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initAttributes()
        makeShadow()
        setHourlyMent()
        addCharaterStyleTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initNavigationBar()
    }
    
    // MARK: - @IBAction Functions
    
    @objc func touchAwardButton(sender: UIButton) {        
        let badgeViewController = BadgeViewController()
        self.navigationController?.pushViewController(badgeViewController, animated: true)
    }
    
    @objc func touchSettingButton(sender: UIButton) {
        let settingStoryboard = UIStoryboard(name: Const.Storyboard.Name.setting, bundle: nil)
        guard let settingViewController = settingStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.setting) as? SettingViewController else {
            return
        }
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    @objc func touchChattingButton(sender: UIButton) {
        let settingStoryboard = UIStoryboard(name: Const.Storyboard.Name.setting, bundle: nil)
        guard let settingViewController = settingStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.setting) as? SettingViewController else {
            return
        }
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    @objc func pushToStyleController() {
        let charaterStoryboard = UIStoryboard(name: Const.Storyboard.Name.characterStyle, bundle: nil)
        guard let charaterStyleViewController = charaterStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.characterStyle) as? CharacterStyleViewController else {
            return
        }
        self.navigationController?.pushViewController(charaterStyleViewController, animated: true)
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        let awardItem = self.navigationItem.makeCustomBarItem(self, action: #selector(touchAwardButton(sender:)), image: Const.Image.medalIcon)
        let chatItem = self.navigationItem.makeCustomBarItem(self, action: #selector(touchSettingButton(sender:)), image: Const.Image.chatIcon)
        let settingItem = self.navigationItem.makeCustomBarItem(self, action: #selector(touchSettingButton(sender:)), image: Const.Image.settingIcon)
        let spacing = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacing.width = 16
        
        self.navigationItem.rightBarButtonItems = [settingItem, spacing, chatItem, spacing, awardItem]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.initTransparentNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
    }
    
    private func initAttributes() {
        challengInfoView.makeRounded(radius: 10)
        
        rotateProgressView()
        progressView.setProgress(0.4, animated: false)
        progressView.progressViewStyle = .bar
        progressView.makeRoundedWithBorder(radius: 22, color: UIColor.white.cgColor, borderWith: 2)
        
        customCharaterButtonView.makeRoundedWithBorder(radius: 22, color: UIColor.white.cgColor, borderWith: 2)
    }
    
    private func makeShadow() {
        challengeInfoShadowView.makeRounded(radius: 10)
        challengeInfoShadowView.dropShadowWithMaskLayer(rounded: 10)
        progressShadowView.makeRounded(radius: 22)
        progressShadowView.dropShadowWithMaskLayer(rounded: 10)
        customCharaterShadowView.makeRounded(radius: 22)
        customCharaterShadowView.dropShadowWithMaskLayer(rounded: 10)
    }
    
    private func addCharaterStyleTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pushToStyleController))
        customCharaterButtonView.addGestureRecognizer(gesture)
    }
    
    private func rotateProgressView() {
        progressView.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
        progressShadowView.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
    }
    
    private func setHourlyMent() {
        let hour = AppDate().getHour()
        
        switch hour {
        case 6...18:
            hourlyMentLabel.text = morningText
        case 0...5, 18...24:
            hourlyMentLabel.text = nightText
        default:
            return
        }
    }
    
}
