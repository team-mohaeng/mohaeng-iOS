//
//  ChallengeViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class ChallengeViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var stampView: UIView!
    @IBOutlet weak var stampStackView: UIStackView!
    @IBOutlet weak var triangleStampView: UIView!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var challengeSubTitleLabel: UILabel!
    @IBOutlet weak var stampImageView1: UIImageView!
    @IBOutlet weak var stampImageView2: UIImageView!
    @IBOutlet weak var stampImageView3: UIImageView!
    @IBOutlet weak var triangleStampImageView1: UIImageView!
    @IBOutlet weak var triangleStampImageView2: UIImageView!
    @IBOutlet weak var triangleStampImageView3: UIImageView!
    @IBOutlet weak var stampStatusLabel: UILabel!
    @IBOutlet weak var challengeDescriptionLabel: UILabel!
    @IBOutlet weak var journeyNameView: UIView!
    @IBOutlet weak var journeyDescriptionView: UIView!
    @IBOutlet weak var viewToImage: NSLayoutConstraint!
    @IBOutlet weak var challengeToStampViewBottom: NSLayoutConstraint!
    @IBOutlet weak var subtitleToTitle: NSLayoutConstraint!
    @IBOutlet weak var stampWidth: NSLayoutConstraint!
    @IBOutlet weak var stackviewToChallengeLabel: NSLayoutConstraint!
    @IBOutlet weak var underTriangleStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var journeyImageView: UIImageView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var selectCourseButton: UIButton!
    
    // MARK: - Properties
    
    var totalStamp = 2
    var currentStamp = 0
    var challengeId = 1
    var initialStampImage: UIImage = Const.Image.typeHchallenge
    var completeStampImage: UIImage = Const.Image.typeHchallengeC
    var currentChallengeIdx = 0
    var completePopUp: AnimationPopUpViewController = AnimationPopUpViewController()
    var stampPopUp: PopUpViewController = PopUpViewController()
    var doingCourse: Bool = false
    
    var triangleStampImageViews: [UIImageView] = []
    
    var course: Course?
    var selectedStampImageView: UIImageView = UIImageView()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStampBackgroundView()
        addtouchGesture()
        initNavigationBar()
        initEmptyView()
        appendImageViewsToArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initNavigationBar()
        getTodayChallenge()
        initJourneyView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        print("viewdidappear")
        stampWidth.constant = triangleStampView.frame.height / 2
        underTriangleStackViewHeight.constant = triangleStampView.frame.height / 2
        initJourneyView()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        let awardItem = initNavigationIconWithSpacing(image: Const.Image.mapIcon, buttonEvent: #selector(touchMapButton(sender:)))
        let settingItem = initNavigationIconWithSpacing(image: Const.Image.listIcon, buttonEvent: #selector(touchListButton(sender:)))
        
        self.navigationItem.rightBarButtonItems = [settingItem, awardItem]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.initNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
    }
    
    private func initNavigationIconWithSpacing(image: UIImage, buttonEvent: Selector) -> UIBarButtonItem {
        let button: UIButton = UIButton.init(type: .custom)
        button.setImage(image, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        button.addTarget(self, action: buttonEvent, for: .touchUpInside)
        
        let item = UIBarButtonItem(customView: button)
        let currWidth = item.customView?.widthAnchor.constraint(equalToConstant: 40)
        currWidth?.isActive = true
        let currHeight = item.customView?.heightAnchor.constraint(equalToConstant: 40)
        currHeight?.isActive = true
        
        return item
    }
    
    private func initJourneyView() {
        journeyNameView.makeRounded(radius: journeyNameView.frame.height / 2)
        journeyDescriptionView.makeRoundedSpecificCorner(corners: [.bottomLeft, .bottomRight, .topRight], cornerRadius: 25)
        journeyDescriptionView.invalidateIntrinsicContentSize()
    }
    
    private func initStampBackgroundView() {
        stampView.makeRounded(radius: 18)
    }
    
    private func initEmptyView() {
        emptyView.isHidden = true
        selectCourseButton.makeRounded(radius: selectCourseButton.frame.height / 2)
    }
    
    private func appendImageViewsToArray() {
        triangleStampImageViews.append(triangleStampImageView1)
        triangleStampImageViews.append(triangleStampImageView2)
        triangleStampImageViews.append(triangleStampImageView3)
    }
    
    private func addtouchGesture() {
        let stampGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchstampAction1(_:)))
        stampImageView1.isUserInteractionEnabled = true
        stampImageView1.addGestureRecognizer(stampGesture)
        
        let stampGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.touchstampAction2(_:)))
        stampImageView2.isUserInteractionEnabled = true
        stampImageView2.addGestureRecognizer(stampGesture2)
        
        let stampGesture3 = UITapGestureRecognizer(target: self, action: #selector(self.touchstampAction3(_:)))
        stampImageView3.isUserInteractionEnabled = true
        stampImageView3.addGestureRecognizer(stampGesture3)
        
        let stampGesture4 = UITapGestureRecognizer(target: self, action: #selector(self.touchStampActionTriangle1(_:)))
        triangleStampImageView1.isUserInteractionEnabled = true
        triangleStampImageView1.addGestureRecognizer(stampGesture4)
        
        let stampGesture5 = UITapGestureRecognizer(target: self, action: #selector(self.touchStampActionTriangle2(_:)))
        triangleStampImageView2.isUserInteractionEnabled = true
        triangleStampImageView2.addGestureRecognizer(stampGesture5)
        
        let stampGesture6 = UITapGestureRecognizer(target: self, action: #selector(self.touchStampActionTriangle3(_:)))
        triangleStampImageView3.isUserInteractionEnabled = true
        triangleStampImageView3.addGestureRecognizer(stampGesture6)
    }
    
    private func initCompleteStamp(totalStamp: Int, currentStamp: Int) {
        if totalStamp == 3 {
            if UIDevice.current.hasNotch {
                // triangle
                for idx in 0..<currentStamp {
                    let imageview = triangleStampImageViews[idx]
                    imageview.image = completeStampImage
                }
            } else {
                for idx in 0..<currentStamp {
                    guard let imageview = stampStackView.subviews[idx] as? UIImageView else {
                        return
                    }
                    imageview.image = completeStampImage
                }
            }
        } else {
            for idx in 0..<currentStamp {
                guard let imageview = stampStackView.subviews[idx] as? UIImageView else {
                    return
                }
                imageview.image = completeStampImage
            }
        }
    }
    
    private func initInitialStamp(totalStamp: Int) {
        if totalStamp == 3 {
            if UIDevice.current.hasNotch {
                // triangle
                for idx in 0..<totalStamp {
                    let imageview = triangleStampImageViews[idx]
                    imageview.image = initialStampImage
                }
            } else {
                for idx in 0..<totalStamp {
                    guard let imageview = stampStackView.subviews[idx] as? UIImageView else {
                        return
                    }
                    imageview.image = initialStampImage
                }
            }
        } else {
            for idx in 0..<totalStamp {
                guard let imageview = stampStackView.subviews[idx] as? UIImageView else {
                    return
                }
                imageview.image = initialStampImage
            }
        }
    }
    
    private func notchCase(totalStamp: Int) {
        stampStackView.isHidden = false
        if UIDevice.current.hasNotch {
            switch totalStamp {
            case 1:
                stampImageView2.isHidden = true
                stampImageView3.isHidden = true
                viewToImage.constant = 22
                challengeToStampViewBottom.constant = 60
                triangleStampView.isHidden = true
            case 2:
                stampImageView3.isHidden = true
                triangleStampView.isHidden = true
                viewToImage.constant = 22
                stackviewToChallengeLabel.constant = 47
                challengeToStampViewBottom.constant = 62
            case 3:
                triangleStampView.isHidden = false
                stampStackView.isHidden = true
                
            default:
                break
            }
            
        } else {
            switch totalStamp {
            case 1:
                stampImageView2.isHidden = true
                stampImageView3.isHidden = true
                triangleStampView.isHidden = true
            case 2:
                stampImageView3.isHidden = true
                triangleStampView.isHidden = true
                viewToImage.constant = 22
                challengeToStampViewBottom.constant = 62
                stackviewToChallengeLabel.constant = 47
            case 3:
                triangleStampView.isHidden = true
                stackviewToChallengeLabel.constant = 41
                challengeToStampViewBottom.constant = 39
                viewToImage.constant = 11
            default:
                break
            }
        }
    }
    
    private func setInitialStamp(property: Int) -> UIImage {
        switch property {
        case 0:
            return Const.Image.typeHchallenge
        case 1:
            return Const.Image.typeMchallenge
        case 2:
            return Const.Image.typeSchallenge
        case 3:
            return Const.Image.typeCchallenge
        default:
            return UIImage()
        }
    }
    
    private func setCompleteStamp(property: Int) -> UIImage {
        switch property {
        case 0:
            return Const.Image.typeHchallengeC
        case 1:
            return Const.Image.typeMchallengeC
        case 2:
            return Const.Image.typeSchallengeC
        case 3:
            return Const.Image.typeCchallengeC
        default:
            return UIImage()
        }
    }
    
    private func findCourseProgressDay(challenges: [Challenge]) -> Int {
            var day = 0
            for challenges in challenges {
                if challenges.situation == 0 {
                    return day - 1
                }
                day += 1
            }
            return day - 1
        }
    
    private func updateData(data: CourseData) {
        // 진행중인 챌린지 인덱스 찾기
        currentChallengeIdx = findCourseProgressDay(challenges: data.course.challenges)
        
        // current stamp
        currentStamp = data.course.challenges[currentChallengeIdx].currentStamp
        
        // get 해서 data 반영하기
        challengeSubTitleLabel.text = data.course.title
        challengeTitleLabel.text = data.course.challenges[currentChallengeIdx].title
        challengeDescriptionLabel.text = data.course.challenges[currentChallengeIdx].challengeDescription
        
        DispatchQueue.main.async {
            self.challengeDescriptionLabel.invalidateIntrinsicContentSize()
            self.initJourneyView()
        }
        
        // 현재 챌린지 id값
        self.challengeId = data.course.challenges[currentChallengeIdx].id
        
        // stamp stack view
        totalStamp = data.course.challenges[currentChallengeIdx].totalStamp
        self.notchCase(totalStamp: totalStamp)
        
        // stamp image
        initialStampImage = setInitialStamp(property: data.course.property)
        completeStampImage = setCompleteStamp(property: data.course.property)
        
        // set current stamp
        initInitialStamp(totalStamp: data.course.challenges[currentChallengeIdx].totalStamp)
        initCompleteStamp(totalStamp: totalStamp, currentStamp: data.course.challenges[currentChallengeIdx].currentStamp)
        
        // 챌린지 완료시 완료처리
        if data.course.challenges[currentChallengeIdx].situation == 2 {
            // 쟈니 이미지 바꾸기
            self.journeyImageView.image = Const.Image.talkjhappyiOS
            // 설명 label 축하 메세지로 바꾸기
            self.stampStatusLabel.text = "오늘의 챌린지 성공!\n내일 새로운 챌린지로 다시 만나요!"
            // 챌린지 description label 바꾸기
            self.challengeDescriptionLabel.text = data.course.challenges[self.currentChallengeIdx].successDescription
        } else {
            // 쟈니 이미지 바꾸기
            self.journeyImageView.image = Const.Image.talkjiOS
            // 설명 label
            self.stampStatusLabel.text = "아이콘을 터치해 인증을 완료할 수 있어요\n자정 전까지 오늘의 챌린지를 성공해보세요!"
        }
    }
    
    // 도장 인증 팝업
    func presentStampPopUp(description: String) {
        
        stampPopUp = PopUpViewController(nibName: "PopUpViewController", bundle: nil)
        stampPopUp.modalPresentationStyle = .overCurrentContext
        stampPopUp.modalTransitionStyle = .crossDissolve
        stampPopUp.popUpUsage = .oneButton
        stampPopUp.popUpActionDelegate = self
        tabBarController?.present(stampPopUp, animated: true, completion: nil)
        
        stampPopUp.pinkButton?.setTitle("완료", for: .normal)
        stampPopUp.descriptionLabel?.text = description
    }
    
    // 챌린지 완료 팝업
    func presentCompletePopUp() {
        completePopUp = AnimationPopUpViewController(nibName: Const.Xib.Name.animationPopUp, bundle: nil)
        completePopUp.modalTransitionStyle = .crossDissolve
        completePopUp.modalPresentationStyle = .overCurrentContext
        completePopUp.popUpActionDelegate = self
        tabBarController?.present(completePopUp, animated: true, completion: nil)
        
        completePopUp.titleLabel.text = "오늘의 챌린지 성공"
        completePopUp.descriptionLabel.text = "챌린지를 성공했으니 나와 함께\n당신의 소확행을 작성하러 가보겠어?"
    }
    
    private func pushToCourseLibraryViewController() {
        let courseLibraryStoryabord = UIStoryboard(name: Const.Storyboard.Name.courseLibrary, bundle: nil)
        guard let courseLibarayViewController = courseLibraryStoryabord.instantiateViewController(withIdentifier: Const.ViewController.Identifier.courseLibrary) as? CourseLibraryViewController else { return }
        
        courseLibarayViewController.doingCourse = false
        
        self.navigationController?.pushViewController(courseLibarayViewController, animated: true)
    }

    // MARK: - Fetch Functions
    
    // MARK: - @IBAction Properties
    
    @objc func touchstampAction1(_ gesture: UITapGestureRecognizer) {
        
        guard let course = self.course else { return }
        presentStampPopUp(description: course.challenges[currentChallengeIdx].userMents[currentChallengeIdx])
        selectedStampImageView = stampImageView1
    }
    
    @objc func touchstampAction2(_ gesture: UITapGestureRecognizer) {
        putTodayChallenge()
        selectedStampImageView = stampImageView2
    }
    
    @objc func touchstampAction3(_ gesture: UITapGestureRecognizer) {
        putTodayChallenge()
        selectedStampImageView = stampImageView3
    }
    
    @objc func touchStampActionTriangle1(_ gesture: UITapGestureRecognizer) {
        guard let course = self.course else { return }
        presentStampPopUp(description: course.challenges[currentChallengeIdx].userMents[currentChallengeIdx])
        selectedStampImageView = triangleStampImageView1
    }
    
    @objc func touchStampActionTriangle2(_ gesture: UITapGestureRecognizer) {
        guard let course = self.course else { return }
        presentStampPopUp(description: course.challenges[currentChallengeIdx].userMents[currentChallengeIdx])
        selectedStampImageView = triangleStampImageView2
    }
    
    @objc func touchStampActionTriangle3(_ gesture: UITapGestureRecognizer) {
        guard let course = self.course else { return }
        presentStampPopUp(description: course.challenges[currentChallengeIdx].userMents[currentChallengeIdx])
        selectedStampImageView = triangleStampImageView3
    }
    
    @objc func touchMapButton(sender: UIButton) {
        let courseStoryboard = UIStoryboard(name: Const.Storyboard.Name.course, bundle: nil)
        guard let courseViewController = courseStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.course) as? CourseViewController else {
            return
        }
        self.navigationController?.pushViewController(courseViewController, animated: true)
    }
    
    @objc func touchListButton(sender: UIButton) {
        let courseLibraryStoryboard = UIStoryboard(name: Const.Storyboard.Name.courseLibrary, bundle: nil)
        guard let courseLibraryViewController = courseLibraryStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.courseLibrary) as? CourseLibraryViewController else {
            return
        }
        courseLibraryViewController.doingCourse = self.doingCourse
        self.navigationController?.pushViewController(courseLibraryViewController, animated: true)
    }
    
    @IBAction func touchSelectCourseButton(_ sender: Any) {
        pushToCourseLibraryViewController()
    }
}

extension ChallengeViewController: PopUpActionDelegate {
    func touchPinkButton(button: UIButton) {
        putTodayChallenge()
        selectedStampImageView.image = completeStampImage
        dismiss(animated: true, completion: nil)
    }
    
    func touchWhiteButton(button: UIButton) {
        return
    }
}

extension ChallengeViewController: AnimationPopUpDelegate {
    func touchPinkButtonInAnimation(button: UIButton) {
        
        self.dismiss(animated: true) {
            let writingStoryboard = UIStoryboard(name: Const.Storyboard.Name.writing, bundle: nil)
            let writingViewController = writingStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.writing)
            
            self.navigationController?.pushViewController(writingViewController, animated: true)
        }
    }
    
    func touchWhiteButtonInAnimation(button: UIButton) {
        return
    }
    
}

extension ChallengeViewController {
    func getTodayChallenge() {
        if UserDefaults.standard.object(forKey: "courseId") != nil {
            
            doingCourse = true
            let courseId = UserDefaults.standard.integer(forKey: "courseId")
            emptyView.isHidden = true
            
            ChallengeAPI.shared.getTodayChallenge(completion: { (response) in
                switch response {
                case .success(let data):
                    if let data = data as? CourseData {
                        
                        self.course = data.course
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
            }, courseId: courseId)
        } else {
            doingCourse = false
            // empty page 띄우기
            emptyView.isHidden = false
            self.navigationController?.hideNavigationBar()
        }
    }
    
    func putTodayChallenge() {
        
        if UserDefaults.standard.integer(forKey: "courseId") != nil {
            
            let courseId = UserDefaults.standard.integer(forKey: "courseId")
            ChallengeAPI.shared.putTodayChallenge(completion: { (response) in
                switch response {
                case .success(let data):
                    if let data = data as? CourseData {
                        
                        // 챌린지 완료 확인 : currentStamp == totalStamp 인지 확인하기
                        let currentStamp = data.course.challenges[self.currentChallengeIdx].currentStamp
                        let totalStamp = data.course.challenges[self.currentChallengeIdx].totalStamp
                        
                        print("currentStamp \(currentStamp)")
                        print("totalStamp \(totalStamp)")
                        
                        if currentStamp == totalStamp {
                            // 챌린지 완료 팝업
                            self.presentCompletePopUp()
//                            self.presentStampPopUp(description: data.course.challenges[self.currentChallengeIdx].userMents[currentStamp-1])
                            // 쟈니 이미지 바꾸기
                            self.journeyImageView.image = Const.Image.talkjhappyiOS
                            // VC에 축하 이미지 넣기
                            // 설명 label 축하 메세지로 바꾸기
                            self.stampStatusLabel.text = "오늘의 챌린지 성공!\n내일 새로운 챌린지로 다시 만나요!"
                            // 챌린지 description label 바꾸기
                            self.challengeDescriptionLabel.text = data.course.challenges[self.currentChallengeIdx].successDescription
                        }
                        
                        // 코스 완료 확인 : totalDays == 방금 완료한 challenge id인지 확인하기
                        let totaldays = data.course.totalDays
                        let currentChallengeId = data.course.challenges[self.currentChallengeIdx].id
                        
                        if totaldays == currentChallengeId {
                            // TODO: - 코스 완료 팝업
                            // 쟈니 이미지 바꾸기
                            self.journeyImageView.image = Const.Image.talkjhappyiOS
                            // VC에 축하 이미지 넣기
                            // 설명 label 축하 메세지로 바꾸기
                            self.stampStatusLabel.text = "오늘의 챌린지 성공!\n내일 새로운 챌린지로 다시 만나요!"
                            // 챌린지 description label 바꾸기
                            self.challengeDescriptionLabel.text = data.course.challenges[self.currentChallengeIdx].successDescription
                            print("코스끝")
                        }
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
            }, courseId: courseId, challengeId: self.challengeId)
        }
    }
}
