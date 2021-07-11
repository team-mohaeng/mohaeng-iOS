//
//  CourseLibraryViewModel.swift
//  Journey
//
//  Created by 초이 on 2021/07/02.
//

import Foundation
import Moya

class CourseListViewModel {
    
    var courses = [Course]()
    
    func getCourseLibrary(completion: @escaping ((ViewModelState) -> Void)) {
        CourseAPI.shared.getCourseLibrary { (response) in
            switch response {
            case .success(let courses):
                if let data = courses as? CoursesData {
                    self.courses = data.courses
                    print(self.courses)
                    completion(.success)
                }
            case .requestErr(let message):
                print("requestErr", message)
                completion(.failure)
            case .pathErr:
                print(".pathErr")
                completion(.failure)
            case .serverErr:
                print("serverErr")
                completion(.failure)
            case .networkFail:
                print("networkFail")
                completion(.failure)
            }
        }
    }
}

struct CourseViewModel {
    let course: Course
    
    // 의존성 주입 (Dependency Injection)
    init(_ course: Course) {
        self.course = course
    }
}

extension CourseListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.courses.count
    }
    
    func courseAtIndex(_ index: Int) -> CourseViewModel {
        let course = self.courses[index]
        return CourseViewModel(course)
    }
}
