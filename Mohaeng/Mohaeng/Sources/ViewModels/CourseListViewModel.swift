//
//  CourseLibraryViewModel.swift
//  Journey
//
//  Created by 초이 on 2021/07/02.
//

import Foundation
import Moya

class CourseListViewModel {
    
    var isProgress = true
    var courses = [CourseLibrary]()
    var propertyCourses: [CourseLibrary] = []
    
    func filterCoursesByProperty(property: Int) -> [CourseLibrary] {
        // category 별 filter
        switch property {
        case 0:
            return self.courses
        case 8:
            return courses.filter { $0.situation == 2 }
        default:
            return courses.filter { $0.property == property }
        }
    }
    
    func getCourseLibrary(completion: @escaping ((ViewModelState) -> Void)) {
        CourseAPI.shared.getCourseLibrary { (response) in
            switch response {
            case .success(let courses):
                if let data = courses as? CourseLibraryData {
                    self.isProgress = data.isProgress
                    self.courses = data.courses
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
    let course: CourseLibrary
    
    // 의존성 주입 (Dependency Injection)
    init(_ course: CourseLibrary) {
        self.course = course
    }
}

extension CourseListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(property: Int, section: Int) -> Int {
                
        return filterCoursesByProperty(property: property).count
    }
    
    func courseAtIndex(property: Int, index: Int) -> CourseViewModel {
        
        let course = filterCoursesByProperty(property: property)[index]
        return CourseViewModel(course)
    }
}
