//
//  CourseLibraryViewModel.swift
//  Journey
//
//  Created by 초이 on 2021/07/02.
//

import Foundation
import Moya

class CourseListViewModel {
    
     // var courses = [CourseLibrary]()
    
    var courses: [CourseLibrary] = [
        CourseLibrary(id: 0, situation: 0, property: 1, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코ㅡ설명인데그냥한번에ㅂㅣ다", totalDays: 7),
        CourseLibrary(id: 1, situation: 0, property: 2, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코ㅡ설명인데그냥한번에ㅂㅣ다이렇게길어도잘나와요~~~잘나오죠완전", totalDays: 7),
        CourseLibrary(id: 2, situation: 0, property: 3, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 7),
        CourseLibrary(id: 3, situation: 0, property: 4, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 3),
        CourseLibrary(id: 4, situation: 0, property: 5, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 7),
        CourseLibrary(id: 5, situation: 0, property: 6, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 7),
        CourseLibrary(id: 6, situation: 0, property: 7, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다명인데그냥한번에ㅂㅣ다", totalDays: 2),
        CourseLibrary(id: 7, situation: 0, property: 0, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 1),
        CourseLibrary(id: 8, situation: 0, property: 4, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데명인데그냥한번에ㅂㅣ다그냥한번에ㅂㅣ다", totalDays: 3),
        CourseLibrary(id: 9, situation: 0, property: 5, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 7),
        CourseLibrary(id: 10, situation: 2, property: 1, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다명인데그냥한번에ㅂㅣ다", totalDays: 7),
        CourseLibrary(id: 11, situation: 2, property: 2, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 2),
        CourseLibrary(id: 12, situation: 2, property: 0, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 1),
        CourseLibrary(id: 13, situation: 2, property: 4, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그명인데그냥한번에ㅂㅣ다냥한번에ㅂㅣ다", totalDays: 3),
        CourseLibrary(id: 14, situation: 2, property: 5, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 7),
        CourseLibrary(id: 15, situation: 2, property: 6, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 7),
        CourseLibrary(id: 16, situation: 2, property: 4, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데명인데그냥한번에ㅂㅣ다그냥한번에ㅂㅣ다", totalDays: 2),
        CourseLibrary(id: 17, situation: 2, property: 0, title: "우앙코스", courseDescription: "ㅇㅣ기ㅓ는코스설명인데그냥한번에ㅂㅣ다", totalDays: 1)
    ]
    
    var propertyCourses: [CourseLibrary] = []
    
    func filterCoursesByProperty(property: Int) -> [CourseLibrary] {
        // category 별 filter
        switch property {
        case 0:
            return self.courses
        default:
            return courses.filter { $0.property == property }
        }
    }
    
    func getCourseLibrary(completion: @escaping ((ViewModelState) -> Void)) {
        CourseAPI.shared.getCourseLibrary { (response) in
            switch response {
            case .success(let courses):
                if let data = courses as? CoursesData {
                    // self.courses = data.courses
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
