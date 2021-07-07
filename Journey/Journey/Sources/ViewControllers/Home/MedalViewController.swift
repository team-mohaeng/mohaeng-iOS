//
//  MedalViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/06.
//

import UIKit

class MedalViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties

    @IBOutlet weak var medalCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        assignDelegate()
        registerXib()
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
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension MedalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.medalCollectionViewCell, for: indexPath) as? MedalCollectionViewCell {
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}
