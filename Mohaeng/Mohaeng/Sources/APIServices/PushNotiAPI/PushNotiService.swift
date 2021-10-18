//
//  PushNotiService.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/17.
//

import Foundation
import Moya

enum PushNotiService {
    case getNotifications
}

extension PushNotiService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getNotifications:
            return Const.URL.notification
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNotifications:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getNotifications:
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
