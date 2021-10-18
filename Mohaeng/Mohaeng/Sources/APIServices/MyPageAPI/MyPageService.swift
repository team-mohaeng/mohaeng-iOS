//
//  MyPageService.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/17.
//

import Foundation
import Moya

enum MyPageService {
    case getMyPage
}

extension MyPageService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getMyPage:
            return Const.URL.myPage
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyPage:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getMyPage:
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
