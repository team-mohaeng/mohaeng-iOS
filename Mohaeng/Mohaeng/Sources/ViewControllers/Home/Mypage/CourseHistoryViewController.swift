//
//  CourseHistoryViewController.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/12.
//

import UIKit

class CourseHistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var courseHistoryCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        setDelegation()
        registerXib()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
        self.navigationItem.title = "챌린지 기록보기"
    }
    
    private func setDelegation() {
        courseHistoryCollectionView.delegate = self
        courseHistoryCollectionView.dataSource = self
    }
    
    private func registerXib() {
        courseHistoryCollectionView.register(UINib(nibName: Const.Xib.Name.courseHistoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.courseHistoryCollectionViewCell)
    }
    
    // MARK: - @IBAction Functions

}

// MARK: - UICollectionViewDelegateFlowLayout

extension CourseHistoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 50, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let courseStoryboard = UIStoryboard(name: Const.Storyboard.Name.course, bundle: nil)
        guard let courseViewController = courseStoryboard.instantiateViewController(withIdentifier: Const.ViewController.Identifier.course) as? CourseViewController else {
            return
        }
        courseViewController.courseViewUsage = .history
        self.navigationController?.pushViewController(courseViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension CourseHistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.courseHistoryCollectionViewCell, for: indexPath) as? CourseHistoryCollectionViewCell {
            
            cell.setCell()
            
            return cell
        }
        return UICollectionViewCell()
    }
}
