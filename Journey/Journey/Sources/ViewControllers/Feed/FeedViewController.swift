//
//  FeedViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - Properties
    
    var headerView: FeedHeaderView = {
        guard let nib = UINib(nibName: "FeedHeaderView", bundle: nil).instantiate(withOwner: self, options: nil).first as? FeedHeaderView else { return FeedHeaderView() }
        return nib
    }()
    var feedBackgroundFrame: UIView = UIView(frame: CGRect(x: 0, y: 249, width: UIScreen.main.bounds.width, height: 224 * (64 / 2) + 200))
    var feedTitleLabel = UILabel()
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var floatingTopButton: UIButton!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        setDelegation()
        registerXib()
        initAtrributes()
        addObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hideNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        headerView.frame = CGRect(x: 0, y: feedCollectionView.safeAreaInsets.top, width: UIScreen.main.bounds.width, height: (205 / 812) * UIScreen.main.bounds.height + 344)
        self.feedCollectionView.insertSubview(self.feedBackgroundFrame, at: 0)
    }
    
    // MARK: - function
    
    private func initNavigationBar() {
        self.navigationController?.hideNavigationBar()
    }
    
    private func setDelegation() {
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
    }
    
    private func initAtrributes() {
        feedCollectionView.backgroundView = UIView()
        feedCollectionView.backgroundView?.addSubview(headerView)
        feedCollectionView.contentInset = .zero
        
        feedBackgroundFrame.backgroundColor = .white
        feedBackgroundFrame.makeRounded(radius: 24)
        feedBackgroundFrame.addSubview(feedTitleLabel)
        
        feedTitleLabel.numberOfLines = 2
        feedTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        feedTitleLabel.text = "오늘은 64명의 쟈기들이 \n행복을 기록했쟈니"
        feedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        feedTitleLabel.topAnchor.constraint(equalTo: feedBackgroundFrame.topAnchor, constant: 38).isActive = true
        feedTitleLabel.leftAnchor.constraint(equalTo: feedBackgroundFrame.leftAnchor, constant: 24).isActive = true
        
        floatingTopButton.contentEdgeInsets = UIEdgeInsets(top: 0.01, left: 0, bottom: 0.01, right: 0)
        floatingTopButton.layer.shadowOffset = CGSize(width: 2, height: 3)
        floatingTopButton.layer.shadowColor = UIColor.black.cgColor
        floatingTopButton.layer.shadowOpacity = 0.1
    }
    
    private func registerXib() {
        feedCollectionView.register(ContentsCollectionViewCell.self, forCellWithReuseIdentifier: Const.Xib.Identifier.contentsCollectionViewCell)
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushToMyDrawerViewController), name: NSNotification.Name("myDrawerCilcked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushToMoodViewController), name: NSNotification.Name("writeHappinessClicked"), object: nil)
    }

    @objc func pushToMyDrawerViewController(notification: NSNotification) {
        let myDrawerStoryboard = UIStoryboard(name: Const.Storyboard.Name.myDrawer, bundle: nil)
        guard let nextVC = myDrawerStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.myDrawer) as? MyDrawerViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func pushToMoodViewController(notification: NSNotification) {
        let myDrawerStoryboard = UIStoryboard(name: Const.Storyboard.Name.mood, bundle: nil)
        guard let nextVC = myDrawerStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.mood) as? MoodViewController else { return }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func touchFloatingTopButton(_ sender: Any) {
        let topOffset = CGPoint(x: 0, y: 0)
        self.feedCollectionView.setContentOffset(topOffset, animated: true)
    }
}

extension FeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Name.contentsCollectionViewCell, for: indexPath) as? ContentsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.makeRounded(radius: 14)
        
        return cell
    }
    
}

extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedDetailStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.feedDetail, bundle: nil)
        let feedDetailViewController = feedDetailStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.feedDetail)
        
        self.navigationController?.pushViewController(feedDetailViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let percent = (244 - offset)/244
        
        if offset < 245 {
            headerView.alpha = max(percent, 0.3)
            statusBarView.alpha = percent
        }
        
        if feedCollectionView.contentOffset.y > 10 {
            UIView.animate(withDuration: 1.0) {
                self.floatingTopButton.alpha = 1.0
                self.floatingTopButton.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 1.0) {
                self.floatingTopButton.alpha = 0.0
            }
        }
    }

}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = width * (156/375)
        let cellHeight = cellWidth * (208/156)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 340, left: 22, bottom: 24, right: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
