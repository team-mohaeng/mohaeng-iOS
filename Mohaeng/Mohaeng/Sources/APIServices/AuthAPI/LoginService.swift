//
//  LoginService.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/13.
//

import Foundation
import Moya

enum LoginService {
    
    case postSignIn(email: String, password: String)
    
}

extension LoginService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .postSignIn(_, _):
            return Const.URL.signInURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignIn(_, _) :
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postSignIn(let email, let password):
            return .requestParameters(parameters: [
                "email": email,
                "password": password
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Conten-Type": "application/json",
            "token": UserDefaults.standard.string(forKey: "fcmToken") ?? ""
        ]
    }
}
