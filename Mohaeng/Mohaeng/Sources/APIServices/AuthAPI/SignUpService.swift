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

    case postEmailCheck(email: String)

    case deleteUser

}

extension SignUpService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .postSignUp(_, _, _):
            return Const.URL.signUpURL

        case .postEmailCheck(_):
            return Const.URL.emailCheckURL

        case .deleteUser:
            return Const.URL.deleteUser

        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignUp(_, _, _):
            return .post

        case .postEmailCheck(_):
            return .post

        case .deleteUser:
            return .delete

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
          
        case .postEmailCheck(let email):
            return .requestParameters(parameters: [
                "email": email
            ], encoding: JSONEncoding.default)
          
        case .deleteUser:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {

        switch self {
        case .postSignUp(_, _, _):
        return [
            "Content-Type": "application/json",
            "token": UserDefaults.standard.string(forKey: "fcmToken") ?? ""
        ]
        case .postEmailCheck(_):
            return [
                "Content-Type": "application/json"
                ]
        case .postSignUp(_, _, _):
            return [
                "Content-Type": "application/json",
                "token": UserDefaults.standard.string(forKey: "fcmToken") ?? ""
            ]
        case .deleteUser:
            return [
                "Content-Type": "application/json",
                "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""

            ]
        }
    }
}
