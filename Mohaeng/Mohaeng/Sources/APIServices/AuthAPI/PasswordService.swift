//
//  PasswordService.swift
//  Journey
//
//  Created by 초이 on 2021/07/12.
//

import Foundation
import Moya

enum PasswordService {
    case putChangedPassword(email: String, password: String)
    case getEmailCode(email: String)
}

extension PasswordService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .putChangedPassword(_, _):
            return Const.URL.passwordURL
        case .getEmailCode(let email):
            return Const.URL.passwordURL + "/\(email)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .putChangedPassword(_, _):
            return .put
        case .getEmailCode(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .putChangedPassword(let email, let password):
            // body가 있는 request - JSONEncoding.default
            return .requestParameters(parameters: [
                "email": email,
                "password": password
            ], encoding: JSONEncoding.default)
        case .getEmailCode(_):
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
