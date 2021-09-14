//
//  SignUpService.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/14.
//

import Foundation
import Moya

enum SignUpService {
    
    case postSignUp(email: String, password: String, nickname: String, gender: Int, birthyear: Int)
}

extension SignUpService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    var path: String {
        switch self {
        case .postSignUp(_, _, _, _, _):
            return Const.URL.signUpURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignUp(_, _, _, _, _):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postSignUp(let email, let password, let nickname, let gender, let birthyear):
            return .requestParameters(parameters: [
                "userId": email,
                "userPw": password,
                "nickname": nickname,
                "gender": gender,
                "birthYear": birthyear
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
