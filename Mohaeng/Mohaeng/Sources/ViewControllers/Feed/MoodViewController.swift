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
    let moodImageArray = [Const.Image.badImage, Const.Image.sosoImage, Const.Image.happyImage]
    var moodImage = Const.Image.badImage
    
    private var currentDate: AppDate?
    private var signUpUser: SignUpUser?
    
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
    
    private let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "btnWritingX")?.resized(to: CGSize(width: 20, height: 20)), for: .normal )
        $0.snp.makeConstraints {
            $0.width.equalTo(63)
            $0.height.equalTo(44)
        }
        $0.tintColor = .Black
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRoundDot()
        makeSpecificRoundButton()
        assignDelegate()
        registerXib()
        initCarouselAttribute()
        initNavigationBar()
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
    
    private func initNavigationBar() {
        navigationController?.initTransparentNavigationBarWithoutBackButton(navigationItem: self.navigationItem)
        closeButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)

        let currentDate = AppDate()
        let currentMonth = currentDate.getMonth()
        let currentDay = currentDate.getDay()
        navigationItem.title = "\(currentMonth)월 \(currentDay)일"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(weight: .regular, size: 14), NSAttributedString.Key.foregroundColor: UIColor.Black]

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
        self.pageStackView.setNeedsLayout()
        UIView.animate(withDuration: 0.3) {
            self.firstDotWidth.constant = first
            self.secondDotWidth.constant = second
            self.thirdDotWidth.constant = third
            self.pageStackView.layoutIfNeeded()
        }
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
        self.dotAnimation(first: 61, second: 10, third: 10)
    }
    
    func secondDotAnimation() {
        self.dotAnimation(first: 10, second: 61, third: 10)
    }
    
    func thirdDotAnimation() {
        self.dotAnimation(first: 10, second: 10, third: 61)
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchNextButton(_ sender: Any) {
        if let moodImage = moodImage {
            let writingViewController = WritingViewController(with: moodImage)
            
            self.navigationController?.pushViewController(writingViewController, animated: true)
        }
        
    }
    
    @objc
    private func buttonDidTapped(_ sender: UIButton) {
        switch sender {
        case closeButton:
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
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
        
        moodImage = moodImageArray[Int(roundedIndex)]
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
        cell.moodImageView.image = moodImageArray[indexPath.row]
        return cell
    }
}
