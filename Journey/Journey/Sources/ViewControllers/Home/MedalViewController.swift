//
//  MedalViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/06.
//

import UIKit

class MedalViewController: UIViewController {
    
    // MARK: - Properties
    
    var totalIncreasedAffinity = 0
    var maxSuccessCount = 0
    var courses = [Course(id: 0, title: "", courseDescription: "", totalDays: 0, situation: 0, property: "", challenges: [])]
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var medalCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        assignDelegate()
        registerXib()
        getMedal()
    }
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        self.navigationItem.title = "나의 업적"
    }
    
    private func assignDelegate() {
        self.medalCollectionView.delegate = self
        self.medalCollectionView.dataSource = self
    }
    
    private func registerXib() {
        medalCollectionView.register(UINib(nibName: Const.Xib.Name.medalCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.medalCollectionViewCell)
        
        self.medalCollectionView.register(UINib(nibName: Const.Xib.Name.medalCollectionReusableView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.Xib.Identifier.medalCollectionReusableView)
    }
    
    private func updateData(data: MedalData) {
        self.totalIncreasedAffinity = data.totalIncreasedAffinity
        self.maxSuccessCount = data.maxSuccessCount
        self.courses = data.courses
        self.medalCollectionView.reloadData()
    }

}

extension MedalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.Xib.Identifier.medalCollectionReusableView, for: indexPath) as? MedalCollectionReusableView {
            
            headerView.setText(affinity: self.totalIncreasedAffinity, successCount: self.maxSuccessCount)
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
}

extension MedalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.medalCollectionViewCell, for: indexPath) as? MedalCollectionViewCell {
            
            cell.setCell(course: courses[indexPath.row])
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension MedalViewController {
    
    func getMedal() {
        CourseAPI.shared.getMedal { (response) in
            
            switch response {
            case .success(let medalData):
                if let data = medalData as? MedalData {
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
