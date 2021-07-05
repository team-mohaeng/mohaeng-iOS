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
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        setDelegation()
        registerXib()
        initAtrributes()
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
    }
    
    private func registerXib() {
        let feedContentsCollectionViewCell = UINib(nibName: "FeedContentsCollectionViewCell", bundle: nil)
        feedCollectionView.register(feedContentsCollectionViewCell, forCellWithReuseIdentifier: "FeedContentsCollectionViewCell")
    }

}

extension FeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedContentsCollectionViewCell", for: indexPath) as? FeedContentsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.makeRounded(radius: 14)
        
        return cell
    }
    
}

extension FeedViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let percent = (244 - offset)/244
        
        if offset < 245 {
            headerView.alpha = max(percent, 0.3)
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
