//
//  CourseService.swift
//  Journey
//
//  Created by 초이 on 2021/07/11.
//

import Foundation
import Moya

// MARK: - Course Service

// 코스 라이브러리 조회 (GET)
// static let coursesURL = "/courses"

// 코스 진행하기 (PUT) : "/courses/:id"

// 완료한 코스 메달 조회 (GET)
// static let medalURL = "/complete"

let testToken2 = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiZXA0UmhZcmJUSE9uaHpBUldOVFNTMTpBUEE5MWJIS1pGdkJuUkV1dEEtYzQxSmN6dDBITzVJQkNyMFhzM0VadjFFcUZSVl9jY05semtDbFQtaWxmT3FGTUFWTmFPUFYxaVhIQjIybHhrcHZJRWNTNW4tMjQtZzY2SVR1d0o1aW9aWlJtYVd5R1Q3XzZiUDhlR1BOZHd2SkNwUWxZb1daQlhHVCJ9LCJpYXQiOjE2MjYwMDYyOTF9.5bzzxZxI2TpOOAHjWHQrbYMgrBOZoZI-e24R9te0_NM"

enum CourseService {
    // 코스 라이브러리 조회
    case getCourseLibrary
    // 코스 진행하기
    case putCourseProgress(id: String)
    // 완료한 코스 메달 조회
    case getMedal
}

extension CourseService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getCourseLibrary:
            return Const.URL.coursesURL
        case .putCourseProgress(let id):
            return Const.URL.coursesURL + "\(id)"
        case .getMedal:
            return Const.URL.coursesURL + Const.URL.medalURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourseLibrary:
            return .get
        case .putCourseProgress(_):
            return .put
        case .getMedal:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCourseLibrary, .getMedal, .putCourseProgress(_):
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Bearer": testToken2
        ]
    }
}
