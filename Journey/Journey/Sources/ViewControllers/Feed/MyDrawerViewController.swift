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
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = CGPoint(x: self.view.center.x, y: self.view.center.y - self.topbarHeight)
        activityIndicator.hidesWhenStopped = false
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    var backgroundView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    // MARK: - Properties
    
    private var myDrawer: [Feed] = []
    private var modalDateView: DatePickerViewController?
    private var currentDate: AppDate?
    private var feedCount = 0
    private var selectedYear: Int?
    private var selectedMonth: Int?
    
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
        myHappinessCollectionView.register(UINib(nibName: Const.Xib.Name.myDrawerCollectionReusableView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.Xib.Identifier.myDrawerCollectionReusableView)
    }
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        
        navigationItem.title = "내 서랍장"
    }
    
    private func initCurrentDate() {
        self.currentDate = AppDate()
        self.selectedYear = currentDate?.getYear()
        self.selectedMonth = currentDate?.getMonth()
        
        guard let year = selectedYear else { return }
        guard let month = selectedMonth else { return }
        getMyDrawer(year: "\(year)", month: convertMonthFormat(month: "\(month)"))
    }
    
    private func setDelegation() {
        myHappinessCollectionView.delegate = self
        myHappinessCollectionView.dataSource = self
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
    
    private func updateData(data: MyDrawerData) {
        self.myDrawer = data.myDrawerSmallSatisfactions
        checkEmptyView()
        myHappinessCollectionView.reloadData()
        self.detachActivityIndicator()
    }
    
    private func convertMonthFormat(month: String) -> String {
        if month.count < 2 {
            return "0\(month)"
        } else {
            return month
        }
    }
    
    private func attachActivityIndicator() {
        backgroundView.backgroundColor = UIColor.white
        self.view.addSubview(backgroundView)
        self.view.addSubview(self.activityIndicator)
    }
    
    private func detachActivityIndicator() {
        if self.activityIndicator.isAnimating {
            self.activityIndicator.stopAnimating()
        }
        self.backgroundView.removeFromSuperview()
        self.activityIndicator.removeFromSuperview()
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
        
        let yearMonthDate = [year, month]
        NotificationCenter.default.post(name: NSNotification.Name("datePickerSelected"), object: yearMonthDate)
        
        getMyDrawer(year: year, month: convertMonthFormat(month: month))
        myHappinessCollectionView.reloadData()
    }
}

extension MyDrawerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        return UICollectionViewCell()
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
        self.attachActivityIndicator()
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
