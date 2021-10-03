//
//  CourseLibraryViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import UIKit

class CourseLibraryViewController: UIViewController {
    
    // MARK: - Properties
    // dummy data
    var courses: [Course] = []
    
    var doingCourse: Bool = true
    var courseListViewModel = CourseListViewModel()
    var askPopUp: PopUpViewController = PopUpViewController()
    var selectedCourseId = 0
    var backgroundView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var selectedProperty = 0
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var courseLibraryCollectionView: UICollectionView!
    @IBOutlet weak var propertyCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        registerXib()
        assignDelegation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchCourses()
    }

    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initNavigationBarWithBackButton(navigationItem: self.navigationItem)
        
        self.navigationItem.title = "코스 목록"
    }
    
    private func registerXib() {
        courseLibraryCollectionView.register(UINib(nibName: Const.Xib.Name.courseLibraryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Name.courseLibraryCollectionViewCell)
    }
    
    private func assignDelegation() {
        courseLibraryCollectionView.delegate = self
        courseLibraryCollectionView.dataSource = self
        
        propertyCollectionView.delegate = self
        propertyCollectionView.dataSource = self
    }
    
    private func fetchCourses() {
        courseListViewModel.getCourseLibrary { state in
            switch state {
            case .success:
                return self.updateUI()
            case .failure:
                return
            }
        }
    }
    
    private func updateUI() {
        self.courseLibraryCollectionView.reloadData()
    }
    
    private func presentAskPopUp(doingCourse: Bool) {
        
        askPopUp = PopUpViewController(nibName: Const.Xib.Name.popUp, bundle: nil)
        askPopUp.modalPresentationStyle = .overCurrentContext
        askPopUp.modalTransitionStyle = .crossDissolve
        askPopUp.popUpUsage = .twoButton
        askPopUp.popUpActionDelegate = self
        tabBarController?.present(askPopUp, animated: true, completion: nil)
        
        if doingCourse {
            // 코스 진행중일 때 (변경)
            askPopUp.titleLabel.text = "쟈기, 지금 포기하는거야?"
            // 쟈니 이미지
            askPopUp.image = Const.Image.bgPopGiveUp
            askPopUp.descriptionLabel.text = "코스를 변경하면 나와의 관계는\n묽어질거야. 감당할 수 있겠어?"
            askPopUp.pinkButton.setTitle("포기 안 해!", for: .normal)
            askPopUp.whiteButton.setTitle("변경할래", for: .normal)
        } else {
            // 진행중인 코스가 없을 때 (시작)
            askPopUp.titleLabel.text = "나와 여정을 떠나보겠어?"
            // 쟈니 이미지
            askPopUp.image = Const.Image.bgStartCourse
            askPopUp.descriptionLabel.text = "당신을 알아갈 수 있는 새롭고\n신나는 일들이 기다리고 있을거야"
            askPopUp.pinkButton.setTitle("좋아!", for: .normal)
            askPopUp.whiteButton.setTitle("다시 생각해볼게", for: .normal)
        }
    }
}

extension CourseLibraryViewController: PopUpActionDelegate {
    func touchPinkButton(button: UIButton) {
        if doingCourse {
            self.dismiss(animated: true, completion: nil)
        } else {
            startCourse(courseId: selectedCourseId)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func touchWhiteButton(button: UIButton) {
        if doingCourse {
            startCourse(courseId: selectedCourseId)
            self.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension CourseLibraryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return courseListViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case propertyCollectionView:
            return AppCourse.count
            
        case courseLibraryCollectionView:
            return courseListViewModel.numberOfRowsInSection(property: selectedProperty, section: 0)
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case propertyCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.courseCategoryCollectionViewCell, for: indexPath) as? CourseCategoryCollectionViewCell {
                
                if indexPath.row == 0 {
                    cell.setLabel(title: "전체")
                } else {
                    if let title = AppCourse(rawValue: indexPath.row-1)?.getKorean() {
                        cell.setLabel(title: title)
                    }
                }
                
                return cell
                
            }
            
        case courseLibraryCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.courseLibraryCollectionViewCell, for: indexPath) as? CourseLibraryCollectionViewCell {
                
                let viewModel = courseListViewModel.courseAtIndex(property: selectedProperty, index: indexPath.row)
                cell.courseViewModel = viewModel
                cell.setButtonTitle(doingCourse: doingCourse)
                
                return cell
            }
        default:
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {
        case propertyCollectionView:
            return UIEdgeInsets(top: 19, left: 18, bottom: 10, right: 18)
        case courseLibraryCollectionView:
            return UIEdgeInsets(top: 22, left: 24, bottom: 0, right: 24)
        default:
            return UIEdgeInsets.zero
        }
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CourseLibraryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case propertyCollectionView:
            return CGSize(width: 59, height: 14)
        case courseLibraryCollectionView:
            return unDoneCellSize(for: indexPath)
        default:
            return CGSize.zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case propertyCollectionView:
            selectedProperty = indexPath.row
            courseLibraryCollectionView.reloadData()
            
        case courseLibraryCollectionView:
            // TODO: - popUp 변경 시 바꿔야 함 현재 터지는 상태
            presentAskPopUp(doingCourse: doingCourse)
            selectedCourseId = courseListViewModel.courseAtIndex(property: selectedProperty, index: indexPath.row).course.id
            UserDefaults.standard.setValue(selectedCourseId, forKey: "courseId")
        default:
            return
        }
        
    }
    
    private func unDoneCellSize(for indexPath: IndexPath) -> CGSize {
        // load cell from Xib
        guard let cell = Bundle.main.loadNibNamed(Const.Xib.Name.courseLibraryCollectionViewCell, owner: self, options: nil)?.first as? CourseLibraryCollectionViewCell else {return CGSize(width: 0, height: 0)}
        
        // configure cell with data in it
        let viewModel = courseListViewModel.courseAtIndex(property: selectedProperty, index: indexPath.row)
        cell.courseViewModel = viewModel
        cell.setButtonTitle(doingCourse: doingCourse)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        // width that you want
        let width = courseLibraryCollectionView.frame.width - 48
        let height: CGFloat = 0
        
        let targetSize = CGSize(width: width, height: height)
        
        // get size with width that you want and automatic height
        let size = cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .defaultHigh, verticalFittingPriority: .fittingSizeLevel)
        // if you want height and width both to be dynamic use below
        // let size = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        
        return size
    }
    
}

extension CourseLibraryViewController {
    func startCourse(courseId: Int) {
        CourseAPI.shared.putCourseProgress(completion: { (response) in
            switch response {
            case .success(let course):
                
                if let data = course as? CourseData {
                    self.fetchCourses()
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
        }, courseId: courseId)
    }
}
