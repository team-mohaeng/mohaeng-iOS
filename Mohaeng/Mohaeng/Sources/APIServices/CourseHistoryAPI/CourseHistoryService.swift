//
//  CourseHistoryService.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/18.
//

import Foundation
import Moya

enum CourseHistoryService {
    case getCourseHistory
}

extension CourseHistoryService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getCourseHistory:
            return Const.URL.courseHistoryURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourseHistory:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCourseHistory:
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
