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
    @IBOutlet weak var emptyView: UIView!
    
    // MARK: - Properties
    private var myDrawer = [Community(postID: 0, nickname: "", mood: 0, mainImage: "", likeCount: 0, content: "", hasLike: false, hashtags: [""], year: "", month: "", day: "", week: "")]
    private var modalDateView: DatePickerViewController?
    private var currentDate: AppDate?
    private var selectedDate: AppDate?
    private var feedCount = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initCurrentDate()
        checkEmptyView()
        initNavigationBar()
        registerXib()
        setDelegation()
        addObservers()
    }
    
    // MARK: - function
    private func registerXib() {
        myHappinessCollectionView.register(ContentsCollectionViewCell.self, forCellWithReuseIdentifier: Const.Xib.Identifier.contentsCollectionViewCell)
        
        myHappinessCollectionView.register(UINib(nibName: Const.Xib.Name.myDrawerCollectionReusableView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.Xib.Identifier.myDrawerCollectionReusableView)
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
        
        guard let year = currentDate?.getYearToString() else { return }
        guard let month = currentDate?.getMonthToString() else { return }
        getMyDrawer(year: year, month: month)
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
        NotificationCenter.default.addObserver(self, selector: #selector(putLikeCount), name: NSNotification.Name("myDrawerLikeClicked"), object: nil)
    }
    
    private func checkEmptyView() {
        if myDrawer.count == 0 {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
    }
    
    private func updateData(data: MyDrawerData) {
        self.myDrawer = data.myDrawerSmallSatisfactions
        checkEmptyView()
        myHappinessCollectionView.reloadData()
    }
    
    @objc func dataReceived(notification: NSNotification) {
        guard let selectedDate = self.selectedDate else { return }
        self.presentDatePickerView(year: selectedDate.getYear(), month: selectedDate.getMonth())
    }
    
    @objc func putLikeCount(notification: Notification) {
        if let likeInfo = notification.object as? LikeButtonInfo {
            if likeInfo.isButtonClicked {
                putFeedLike(postId: myDrawer[likeInfo.cellIndex].postID)
            } else {
                putFeedUnlike(postId: myDrawer[likeInfo.cellIndex].postID)
            }
        }
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
        NotificationCenter.default.post(name: NSNotification.Name("datePickerSelected"), object: selectedDate)
        
        guard let year = selectedDate?.getYearToString() else { return }
        guard let month = selectedDate?.getMonthToString() else { return }
        
        getMyDrawer(year: year, month: month)
        myHappinessCollectionView.reloadData()
    }
}

extension MyDrawerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myDrawer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = myHappinessCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.contentsCollectionViewCell, for: indexPath) as? ContentsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.makeRounded(radius: 14)
        cell.setData(data: myDrawer[indexPath.row], viewController: .myDrawer)
        
        return cell
    }
}

extension MyDrawerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Const.Xib.Identifier.myDrawerCollectionReusableView, for: indexPath)
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

extension MyDrawerViewController {
    func getMyDrawer(year: String, month: String) {
        FeedAPI.shared.getMyDrawer(year: year, month: month) { (response) in
            switch response {
            case .success(let myDrawer):
                if let data = myDrawer as? MyDrawerData {
                    self.updateData(data: data)
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}


extension MyDrawerViewController {
    
    func putFeedLike(postId: Int) {
        FeedAPI.shared.putFeedLike(postId: postId) { (response) in
            switch response {
            case .success(_):
                break
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
        
    }
    
    func putFeedUnlike(postId: Int) {
        FeedAPI.shared.putFeedUnlike(postId: postId) { (response) in
            switch response {
            case .success(_):
                break
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
}
