//
//  MyDrawerViewController.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/06.
//

import UIKit

class MyDrawerViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var myHappinessCollectionView: UICollectionView!
    
    // MARK: - Properties
    private var modalDateView: DatePickerViewController?
    private var currentDate: AppDate?
    private var selectedDate: AppDate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        registerXib()
        initCurrentDate()
        setDelegation()
        addObservers()
    }
    
    // MARK: - function
    private func registerXib() {
        myHappinessCollectionView.register(UINib(nibName: Const.Xib.Name.feedContentsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.feedContentsCollectionViewCell)
        
        myHappinessCollectionView.register(UINib(nibName:  Const.Xib.Name.myDrawerCollectionReusableView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.Xib.Identifier.myDrawerCollectionReusableView)
    }

    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        
        navigationItem.title = "내 서랍장"
        
    }
    
    private func initCurrentDate() {
        self.currentDate = AppDate()
        self.selectedDate = AppDate()
        self.modalDateView = DatePickerViewController()
        self.modalDateView?.datePickerDataDelegate = self
    }
    
    private func setDelegation() {
        myHappinessCollectionView.delegate = self
        myHappinessCollectionView.dataSource = self
    }
    
    private func presentDatePickerView(year: Int, month: Int) {
        guard let modalDateView = self.modalDateView else { return }
        modalDateView.year = year
        modalDateView.month = month
        modalDateView.modalPresentationStyle = .custom
        modalDateView.transitioningDelegate = self
        self.present(modalDateView, animated: true, completion: nil)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(dataReceived), name: NSNotification.Name("calendarButtonClicked"), object: nil)
    }
    
    @objc func dataReceived(notification: NSNotification) {
        guard let selectedDate = self.selectedDate else { return }
        self.presentDatePickerView(year: selectedDate.getYear(), month: selectedDate.getMonth())
    }
    
}

extension MyDrawerViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension MyDrawerViewController: DatePickerViewDelegate {
    func passData(_ date: String) {
        self.selectedDate = AppDate(formattedDate: date, with: ". ")
        NotificationCenter.default.post(name: NSNotification.Name("datePickerSelected"), object: date)
    }
}

extension MyDrawerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = myHappinessCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.feedContentsCollectionViewCell, for: indexPath) as? FeedContentsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.makeRounded(radius: 14)
        
        return cell
    }
}

extension MyDrawerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyDrawerCollectionReusableView", for: indexPath)
            return headerView
        default:
            assert(false, "에러")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 78)
    }
}

extension MyDrawerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = width * (156/375)
        let cellHeight = cellWidth * (208/156)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 22, bottom: 24, right: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
