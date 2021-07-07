//
//  CourseLibraryViewModel.swift
//  Journey
//
//  Created by 초이 on 2021/07/02.
//

import Foundation

struct CourseListViewModel {
    let courses: [Course]
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
