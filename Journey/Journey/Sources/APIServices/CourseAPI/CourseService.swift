//
//  CourseService.swift
//  Journey
//
//  Created by 초이 on 2021/07/11.
//

import Foundation
import Moya

// MARK: - Course Service

enum CourseService {
    // 코스 라이브러리 조회
    case getCourseLibrary
    // 코스 진행하기
    case putCourseProgress(id: Int)
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
            "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
        ]
    }
}
