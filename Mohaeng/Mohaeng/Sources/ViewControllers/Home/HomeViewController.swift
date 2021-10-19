//
//  HomeViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

import Lottie

class HomeViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var challengInfoView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var customCharaterButtonView: UIView!
    @IBOutlet weak var hourlyMentLabel: UILabel!
    @IBOutlet weak var challengeInfoShadowView: UIView!
    @IBOutlet weak var progressShadowView: UIView!
    @IBOutlet weak var customCharaterShadowView: UIView!
    @IBOutlet weak var courseProgressLabel: UILabel!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var characterLottieView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // MARK: - Properties
    
    private let happyPopUp = HappyPopUpViewController()
    private let animationView = AnimationView()
    private var rewardButton: UIBarButtonItem!
    private var chattingButton: UIBarButtonItem!
    private var mypageButton: UIBarButtonItem!
    private var morningText: String = "아침이야!\n오늘 하루도 화이팅"
    private var nightText: String = "벌써 밤이야!\n인증하고 일찍자자"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initAttributes()
        rotateProgressView()
        makeShadow()
        addTapGesture()
        getHomeInfomation()
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
    
    @objc func touchUserButton(sender: UIButton) {
        let myPageStoryboard = UIStoryboard(name: Const.Storyboard.Name.myPage, bundle: nil)
        guard let myPageViewController = myPageStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.myPage) as? MyPageViewController else {
            return
        }
        self.navigationController?.pushViewController(myPageViewController, animated: true)
    }
    
    @objc func touchChattingButton(sender: UIButton) {
        let notificationStoryboard = UIStoryboard(name: Const.Storyboard.Name.notification, bundle: nil)
        guard let notificationViewController = notificationStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.notification) as? NotificationViewController else {
            return
        }
        self.navigationController?.pushViewController(notificationViewController, animated: true)
    }
    
    @objc func pushToStyleController() {
        let charaterStoryboard = UIStoryboard(name: Const.Storyboard.Name.characterStyle, bundle: nil)
        guard let charaterStyleViewController = charaterStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.characterStyle) as? CharacterStyleViewController else {
            return
        }
        self.navigationController?.pushViewController(charaterStyleViewController, animated: true)
    }
    
    @objc func presentHappyPopUp() {
        happyPopUp.modalTransitionStyle = .crossDissolve
        happyPopUp.modalPresentationStyle = .overCurrentContext
        
        tabBarController?.present(happyPopUp, animated: true, completion: nil)
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        let medalItem = self.navigationItem.makeCustomBarItem(self, action: #selector(touchAwardButton(sender:)), image: Const.Image.medalIcon)
        let chatItem = self.navigationItem.makeCustomBarItem(self, action: #selector(touchChattingButton(sender:)), image: Const.Image.chatIcon)
        let userItem = self.navigationItem.makeCustomBarItem(self, action: #selector(touchUserButton(sender:)), image: Const.Image.userIcon)
        
        self.navigationController?.initWithThreeCustomButtons(
            navigationItem: self.navigationItem,
            firstButton: medalItem,
            secondButton: chatItem,
            thirdButton: userItem)
    }
    
    private func initAttributes() {
        challengInfoView.makeRounded(radius: 10)
        
        progressView.progressViewStyle = .bar
        progressView.makeRoundedWithBorder(radius: 22, color: UIColor.white.cgColor, borderWith: 2)
        
        customCharaterButtonView.makeRoundedWithBorder(radius: 22, color: UIColor.white.cgColor, borderWith: 2)
    }
    
    private func setProgressBar(percent: Float) {
        progressView.setProgress(percent, animated: false)
    }
    
    private func makeShadow() {
        challengeInfoShadowView.makeRounded(radius: 10)
        challengeInfoShadowView.dropShadowWithMaskLayer(rounded: 10)
        progressShadowView.makeRounded(radius: 22)
        progressShadowView.dropShadowWithMaskLayer(rounded: 10)
        customCharaterShadowView.makeRounded(radius: 22)
        customCharaterShadowView.dropShadowWithMaskLayer(rounded: 10)
    }
    
    private func addTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pushToStyleController))
        customCharaterButtonView.addGestureRecognizer(gesture)
        
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(presentHappyPopUp))
        progressView.addGestureRecognizer(gesture2)
    }
    
    private func rotateProgressView() {
        progressView.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
        progressShadowView.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
    }
    
    private func setHourlyMent(nickname: String) {
        let hour = AppDate().getHour()
        
        switch hour {
        case 6...18:
            hourlyMentLabel.text = "\(nickname)! " + morningText
        case 0...5, 18...24:
            hourlyMentLabel.text = "\(nickname)! " + nightText
        default:
            return
        }
    }
    
    private func setLottieView(url: URL) {
        animationView.frame = characterLottieView.bounds
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        
        characterLottieView.addSubview(animationView)
        playLottieAnimation(url: url)
    }
    
    private func playLottieAnimation(url: URL) {
        animationView.setAnimation(from: url) { (animationView) in
            animationView.play()
        }
    }
    
    private func updateData(data: Home) {
        backgroundImageView.updateServerImage(data.characterSkin)
        setHourlyMent(nickname: data.nickname)
        courseProgressLabel.text = "코스 진행률 \(data.course.percent)%"
        challengeTitleLabel.text = data.course.challengeTitle
        setProgressBar(percent: Float(data.happy) / Float(data.fullHappy))
        setLottieView(url: URL(string: data.characterLottie)!)
        levelLabel.text = "Lv \(data.level)"
        happyPopUp.data = data
    }
    
}

extension HomeViewController {
    
    func getHomeInfomation() {
        HomeAPI.shared.getHomeInfo { response in
            switch response {
            case .success(let data):
                if let data = data as? Home {
                    self.updateData(data: data)
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
}
