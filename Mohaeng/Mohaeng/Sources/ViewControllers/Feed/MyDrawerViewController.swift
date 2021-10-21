//
//  MyDrawerViewController.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/06.
//

import UIKit

class MyDrawerViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    
    // MARK: - Properties
    
    private var myDrawer: [Feed] = [Feed(postID: 0, course: "", challenge: 0, image: "", mood: 0, content: "", nickname: "", year: "", month: "", day: "", weekday: "", emoji: [Emoji(id: 0, count: 0)], myEmoji: 0, isReport: false, isDelete: false)]
    private var modalDateView: DatePickerViewController?
    private var currentDate: AppDate?
    private var feedCount = 0
    private var selectedYear: Int?
    private var selectedMonth: Int?
    private var writingStatus: Bool = false
    
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
        feedCollectionView.register(UINib(nibName: Const.Xib.Name.myDrawerCollectionReusableView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.Xib.Identifier.myDrawerCollectionReusableView)
        feedCollectionView.register(UINib(nibName: Const.Xib.Name.feedCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.feedCollectionViewCell)
    }
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
        
        navigationItem.title = "내 서랍장"
    }
    
    private func initCurrentDate() {
        self.currentDate = AppDate()
        self.selectedYear = currentDate?.getYear()
        self.selectedMonth = currentDate?.getMonth()
        
        guard let year = selectedYear else { return }
        guard let month = selectedMonth else { return }
        getMyDrawer(year: year, month: month)
    }
    
    private func setDelegation() {
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(presentPickerView), name: NSNotification.Name("calendarButtonClicked"), object: nil)
    }
    
    private func checkEmptyView() {
        if myDrawer.count == 0 {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
    }
    
    private func updateData(data: [Feed]) {
        self.myDrawer = data
        checkEmptyView()
        feedCollectionView.reloadData()
    }
    
    func setWritingStatus(writingStatus: Bool) {
        self.writingStatus = writingStatus
    }
    
    @objc func presentPickerView(notification: NSNotification) {
        guard let year = selectedYear, let month = selectedMonth else { return }
        
        self.modalDateView = DatePickerViewController()
        self.modalDateView?.datePickerDataDelegate = self
        guard let modalDateView = self.modalDateView else { return }
        modalDateView.year = year
        modalDateView.month = month
        modalDateView.modalPresentationStyle = .custom
        modalDateView.transitioningDelegate = self
        
        self.present(modalDateView, animated: true, completion: nil)
    }
    
}

extension MyDrawerViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension MyDrawerViewController: DatePickerViewDelegate {
    func passData(_ year: String, _ month: String) {
        self.selectedYear = Int(year)
        self.selectedMonth = Int(month)
        
        guard let unwrappedYear = selectedYear else { return }
        guard let unwrappedMonth = selectedMonth else { return }
        
        let yearMonthDate = [year, month]
        NotificationCenter.default.post(name: NSNotification.Name("datePickerSelected"), object: yearMonthDate)
        
        getMyDrawer(year: unwrappedYear, month: unwrappedMonth)
        feedCollectionView.reloadData()
    }
}

extension MyDrawerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedDetailStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.feedDetail, bundle: nil)
        guard let feedDetailViewController = feedDetailStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.feedDetail) as? FeedDetailViewController else { return }
        
        feedDetailViewController.setMyDrawer(feeds: myDrawer)
        feedDetailViewController.setPreviousController(viewController: .myDrawer)
        feedDetailViewController.setSelectedContentsIndexPath(indexPath: indexPath)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(feedDetailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myDrawer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Name.feedCollectionViewCell, for: indexPath) as? FeedCollectionViewCell else { return UICollectionViewCell() }
        
        if writingStatus && indexPath.row == 0 {
            cell.configureTodayCellUI()
        } else {
            cell.configureDefaultUI()
        }
        
        cell.setData(data: myDrawer[indexPath.row])
        
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
        return CGSize(width: collectionView.frame.width, height: 58)
    }
}

extension MyDrawerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellWidth = width * (375 / 375)
        let cellHeight = cellWidth * (144 / 375)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}

extension MyDrawerViewController {
    
    func getMyDrawer(year: Int, month: Int) {
        FeedAPI.shared.getMyDrawer(year: year, month: month) { response in
            switch response {
            case .success(let data):
                if let data = data as? [Feed] {
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
