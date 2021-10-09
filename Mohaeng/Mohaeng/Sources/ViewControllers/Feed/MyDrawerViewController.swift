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
    
    private var myDrawer: [Feed] = [
        Feed(postID: 0, course: "뽀득뽀득 세균 퇴치", challenge: 3, image: "imageUrl", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 승찬이 개때리러간다 ㅋㅋ ", nickname: "초이초이", year: "2021", month: "8", day: "22", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false),
        Feed(postID: 0, course: "나는야 지구촌 촌장", challenge: 1, image: "imageUrl", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 덤덤댄스 릴스 췄당 ㅋㅋ", nickname: "초이초이", year: "2021", month: "8", day: "21", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false),
        Feed(postID: 0, course: "초급 사진가", challenge: 2, image: "imageUrl", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 선선한 날씨에 산책했어요. 윤예지 정초이 어쩌구 저쩌구 메롱 야호", nickname: "초이초이", year: "2021", month: "8", day: "20", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false),
        Feed(postID: 0, course: "거침없이 하이킥", challenge: 2, image: "imageUrl", mood: 2, content: "초이초이 ㅋㅋ", nickname: "김승찬", year: "2021", month: "8", day: "19", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false),
        Feed(postID: 0, course: "초급 사진가", challenge: 2, image: "imageUrl", mood: 2, content: "맛있는 피자에 시원한 맥주 먹고 선선한 날씨에 산책했어요. 윤예지 정초이 어쩌구 저쩌구 메롱 야호", nickname: "초이초이", year: "2021", month: "8", day: "20", weekday: "일", emoji: [Emoji(emojiID: 1, emojiCount: 5)], myEmoji: 0, isReport: true, isDelete: false)]
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
        //        getMyDrawer(year: "\(year)", month: convertMonthFormat(month: "\(month)"))
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
    
    private func updateData(data: MyDrawerData) {
        self.myDrawer = data.myDrawerSmallSatisfactions
        checkEmptyView()
        feedCollectionView.reloadData()
    }
    
    private func convertMonthFormat(month: String) -> String {
        if month.count < 2 {
            return "0\(month)"
        } else {
            return month
        }
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
        
        //        getMyDrawer(year: year, month: convertMonthFormat(month: month))
        feedCollectionView.reloadData()
    }
}

extension MyDrawerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myDrawer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Name.feedCollectionViewCell, for: indexPath) as? FeedCollectionViewCell else { return UICollectionViewCell() }
        
        let writingStatus: Int = 1 /// temp
        
        if writingStatus == 1 && indexPath.row == 0 {
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
