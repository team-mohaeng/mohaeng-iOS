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
    case putNickname(nickname: String)
}

extension MyPageService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getMyPage:
            return Const.URL.myPage
        case .putNickname(_):
            return Const.URL.myPage
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyPage:
            return .get
        case .putNickname(_):
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getMyPage:
            return .requestPlain
        case .putNickname(let nickname):
            return .requestParameters(parameters: [
                "nickname": nickname
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
        ]
    }
        
}
