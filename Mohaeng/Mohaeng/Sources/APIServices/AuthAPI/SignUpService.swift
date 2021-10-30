//
//  SignUpService.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/14.
//

import Foundation
import Moya

enum SignUpService {
    
    case postSignUp(email: String, password: String, nickname: String)
}

extension SignUpService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .postSignUp(_, _, _):
            return Const.URL.signUpURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignUp(_, _, _):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postSignUp(let email, let password, let nickname):
            return .requestParameters(parameters: [
                "email": email,
                "password": password,
                "nickname": nickname
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "token": UserDefaults.standard.string(forKey: "fcmToken") ?? ""
        ]
    }
}
