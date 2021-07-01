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
    let courses: [Course] = [
        Course(id: 1, title: "뽀득뽀득 세균 퇴치", description: "나 쟈니가 인간세계에 처음 도착했을 때 사람들이 청결에 대해 은근히 무심한 것이 신기했쟈니. 내가 사는 별에서는 상상도 할 수 없쟈니.", courseDays: 7, situation: 0, property: "water"),
        Course(id: 2, title: "가나다라마바사 퇴치", description: "해당 합의안을 중대본에 전달하고, 최종 결과는 이날 오후 발표할 예정이다. 해당 합의안을 중대본에 전달하고, 최종", courseDays: 2, situation: 0, property: "water"),
        Course(id: 3, title: "쟈니 인간세계 오기", description: "얘들아 오늘 일 하다가 심심하면 마니또 삼행시 이벤트 참여해줘,,,얘들아 오늘 일 하다가 심심하면 마니또 삼행시 이벤트 참여해줘,,,", courseDays: 10, situation: 0, property: "water"),
        Course(id: 4, title: "이것은 더미데이터", description: "걍 아무글이나 써보는 중인데 이렇게 짧으면 어케 나오나", courseDays: 7, situation: 0, property: "water"),
        // Course(id: 5, title: "더미", description: "나 쟈니가 인간세계에 처음 도착했을 때 사람들이 청결에 대해 은근히 무심한 것이 신기했쟈니. 내가 사는 별에서는 상상도 할 수 없쟈니.", courseDays: 3, situation: 1, property: "water"),
        Course(id: 6, title: "더미데이터 입니다", description: "그색긴널사랑하는게아냐 ~그색긴널사랑하는게아냐 ~그색긴널사랑하는게아냐 ~그색긴널사랑하는게아냐 ~그색긴널사랑하는게아냐 ~", courseDays: 4, situation: 2, property: "water"),
        Course(id: 7, title: "이미 한 것들 잘 나오나", description: "이렇게 짧은 글은 없겠지만 그래두 해봄", courseDays: 7, situation: 2, property: "water"),
        Course(id: 8, title: "어제 끝난 코스임", description: "마지막 셀입니다요. 마지막 셀입니다요. 마지막 셀입니다요. 마지막 셀입니다요. 마지막 셀입니다요. 마지막 셀입니다요. ", courseDays: 5, situation: 2, property: "water")
    ]
    
    let doingCourse: Bool = true
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var courseLibraryCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        registerXib()
        assignDelegation()
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
}

// MARK: - UICollectionViewDataSource

extension CourseLibraryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch courses[indexPath.row].situation {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.undoneCourseCollectionViewCell, for: indexPath) as? UndoneCourseCollectionViewCell {
                
                cell.setCell(course: courses[indexPath.row], doingCourse: doingCourse)
                
                return cell
            }
            
        case 2:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.doneCourseCollectionViewCell, for: indexPath) as? DoneCourseCollectionViewCell {
                
                cell.setCell(course: courses[indexPath.row], doingCourse: doingCourse)
                
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
    
}
