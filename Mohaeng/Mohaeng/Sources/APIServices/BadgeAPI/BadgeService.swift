//
//  BadgeService.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/08.
//

import Foundation
import Moya

enum BadgeService {
   case getBadges
}

extension BadgeService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getBadges:
            return Const.URL.badge
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBadges:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getBadges:
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
