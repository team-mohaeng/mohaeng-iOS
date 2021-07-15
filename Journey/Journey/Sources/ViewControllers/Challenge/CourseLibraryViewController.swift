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
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var courseLibraryCollectionView: UICollectionView!
    
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
        
        self.navigationItem.title = "코스 둘러보기"
    }
    
    private func registerXib() {
        courseLibraryCollectionView.register(UINib(nibName: Const.Xib.Name.doneCourseCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Name.doneCourseCollectionViewCell)
        courseLibraryCollectionView.register(UINib(nibName: Const.Xib.Name.undoneCourseCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Name.undoneCourseCollectionViewCell)
    }
    
    private func assignDelegation() {
        courseLibraryCollectionView.delegate = self
        courseLibraryCollectionView.dataSource = self
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
            askPopUp.descriptionLabel.text = "코스를 변경하면 나와의 관계는\n묽어질거야. 감당할 수 있겠어?"
            askPopUp.pinkButton.setTitle("포기 안 해!", for: .normal)
            askPopUp.whiteButton.setTitle("변경할래", for: .normal)
        } else {
            // 진행중인 코스가 없을 때 (시작)
            askPopUp.titleLabel.text = "나와 여정을 떠나보겠어?"
            // 쟈니 이미지
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
        return courseListViewModel.numberOfRowsInSection(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch courseListViewModel.courseAtIndex(indexPath.row).course.situation {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.undoneCourseCollectionViewCell, for: indexPath) as? UndoneCourseCollectionViewCell {
                
                let viewModel = courseListViewModel.courseAtIndex(indexPath.row)
                cell.courseViewModel = viewModel
                cell.setButtonTitle(doingCourse: doingCourse)
                
                return cell
            }
            
        case 2:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.doneCourseCollectionViewCell, for: indexPath) as? DoneCourseCollectionViewCell {
                
                let viewModel = courseListViewModel.courseAtIndex(indexPath.row)
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
        return UIEdgeInsets(top: 22, left: 24, bottom: 0, right: 24)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CourseLibraryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 48, height: 306)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentAskPopUp(doingCourse: doingCourse)
        selectedCourseId = courseListViewModel.courseAtIndex(indexPath.row).course.id
        UserDefaults.standard.setValue(selectedCourseId, forKey: "courseId")
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
