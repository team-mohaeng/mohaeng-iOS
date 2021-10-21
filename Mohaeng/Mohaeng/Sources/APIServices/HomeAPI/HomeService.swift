//
//  HomeService.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/12.
//

import Foundation
import Moya

enum HomeService {
    case getHomeInfo
}

extension HomeService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getHomeInfo:
            return Const.URL.homeURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHomeInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getHomeInfo:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? "",
            "client": "ios"
        ]
    }
        
}
