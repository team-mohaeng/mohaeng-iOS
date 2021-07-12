//
//  HomeService.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/12.
//

import Foundation
import Moya

let testToken3 = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiZXA0UmhZcmJUSE9uaHpBUldOVFNTMTpBUEE5MWJIS1pGdkJuUkV1dEEtYzQxSmN6dDBITzVJQkNyMFhzM0VadjFFcUZSVl9jY05semtDbFQtaWxmT3FGTUFWTmFPUFYxaVhIQjIybHhrcHZJRWNTNW4tMjQtZzY2SVR1d0o1aW9aWlJtYVd5R1Q3XzZiUDhlR1BOZHd2SkNwUWxZb1daQlhHVCJ9LCJpYXQiOjE2MjYwMDYyOTF9.5bzzxZxI2TpOOAHjWHQrbYMgrBOZoZI-e24R9te0_NM"


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
            "Bearer": testToken3
        ]
    }
        
}
