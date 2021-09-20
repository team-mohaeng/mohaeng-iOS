//
//  MoodViewController.swift
//  Mohaeng
//
//  Created by 김승찬 on 2021/09/17.
//

import UIKit

class MoodViewController: UIViewController {
    
    // MARK: - Properties
    
    let cellSize = CGSize(width: 160, height: 160)
    var minItemSpacing: CGFloat = 10
    var moodImageArray: [String] = ["happyImage", "sosoImage", "badImage"]
    
    private var currentDate: AppDate?
    private var navigationMonth: Int?
    private var navigationDate: Int?
    
    private var signUpUser: SignUpUser?
    private var userName: String?
    
    // MARK: @IBOutlet Properties
    
    @IBOutlet weak var firstDotWidth: NSLayoutConstraint!
    @IBOutlet weak var secondDotWidth: NSLayoutConstraint!
    @IBOutlet weak var thirdDotWidth: NSLayoutConstraint!
    @IBOutlet weak var pageStackView: UIStackView!
    
    @IBOutlet weak var firstDot: UIView!
    @IBOutlet weak var secondDot: UIView!
    @IBOutlet weak var thirdDot: UIView!
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var moodTodayLabel: UILabel!
    @IBOutlet weak var moodCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRoundDot()
        makeSpecificRoundButton()
        initTodayMood()
        initNavigationBar()
        assignDelegate()
        registerXib()
        initCarouselAttribute()
       
    }
    
    // MARK: - Functions
    
    private func makeRoundDot() {
        firstDot.makeRounded(radius: 5)
        secondDot.makeRounded(radius: 5)
        thirdDot.makeRounded(radius: 5)
    }
    
    private func makeSpecificRoundButton() {
        nextButton.layer.cornerRadius = 29
        nextButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func initTodayMood() {
        self.signUpUser = SignUpUser()
        self.userName = signUpUser?.nickname
        moodTodayLabel.text = "\(String(describing: userName))의 오늘은 어땠어?"
    }
    
    private func initNavigationBar() {
        
        self.currentDate = AppDate()
        self.navigationMonth = currentDate?.getMonth()
        self.navigationDate = currentDate?.getDay()
        
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        navigationItem.title = "\(navigationMonth!)월 \(navigationDate!)일"
        
    }
    
    private func assignDelegate() {
        moodCollectionView.delegate = self
        moodCollectionView.dataSource = self
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: Const.Xib.Name.moodCollectionViewCell, bundle: nil)
        moodCollectionView.register(nibName, forCellWithReuseIdentifier: Const.Xib.Name.moodCollectionViewCell)
    }
    
    private func dotAnimation(first: CGFloat, second: CGFloat, third: CGFloat) {
        firstDotWidth.constant = first
        secondDotWidth.constant = second
        thirdDotWidth.constant = third
    }
    
    func initCarouselAttribute() {
        
        let layout = CarouselLayout()
        
        layout.itemSize = CGSize(width: moodCollectionView.frame.size.width * 0.35, height: moodCollectionView.frame.size.height * 0.35)
        
        layout.sideItemScale = 0.6
        layout.spacing = 40
        layout.isPagingEnabled = true
        layout.sideItemAlpha = 0.5
        
        moodCollectionView.collectionViewLayout = layout
    }
    
    func firstDotAnimation() {
        self.pageStackView.setNeedsLayout()
        UIView.animate(withDuration: 0.3) {
            self.dotAnimation(first: 61, second: 10, third: 10)
            self.pageStackView.layoutIfNeeded()
        }
    }
    
    func secondDotAnimation() {
        self.pageStackView.setNeedsLayout()
        UIView.animate(withDuration: 0.3) {
            self.dotAnimation(first: 10, second: 61, third: 10)
            self.pageStackView.layoutIfNeeded()
        }
    }
    
    func thirdDotAnimation() {
        self.pageStackView.setNeedsLayout()
        UIView.animate(withDuration: 0.3) {
            self.dotAnimation(first: 10, second: 10, third: 61)
            self.pageStackView.layoutIfNeeded()
        }
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchNextButton(_ sender: Any) {
        
        let writingStoryboard = UIStoryboard(name: Const.Storyboard.Name.writing, bundle: nil)
        guard let writingViewController = writingStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.writing) as? WritingViewController else { return }
    
        self.navigationController?.pushViewController(writingViewController, animated: true)
    }
}

    // MARK: - Extension

extension MoodViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 페이징이 될 때마다 라벨의 텍스트 변경
        
        let cellWidthIncludeSpacing = cellSize.width + minItemSpacing
        let offsetX = moodCollectionView.contentOffset.x
        
        let index = (offsetX + moodCollectionView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex = round(index)
        
        switch Int(roundedIndex) {
        case 0:
            moodLabel.text = "기분 좋아!"
            firstDotAnimation()
        case 1:
            moodLabel.text = "보통이야"
            secondDotAnimation()
        case 2:
            moodLabel.text = "안좋아..."
            thirdDotAnimation()
        default:
            break
        }
    }
}

extension MoodViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}

extension MoodViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moodImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = moodCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.moodCollectionViewCell, for: indexPath) as? MoodCollectionViewCell else {return UICollectionViewCell()}
        cell.setData(moodImageName: moodImageArray[indexPath.row])
        
        return cell
    }
}
