//
//   KakaoService.swift
//  Mohaeng
//
//  Created by 김승찬 on 2021/10/20.
//

import Foundation
import Moya

enum SocialService {
    case postKakaoSignUp(idToken: String, nickname: String)
    case postKakaoLogin(idToken: String)
    
    case postAppleSignUp(idToken: String, nickname: String)
    case postAppleLogin(idToken: String)
}

extension SocialService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .postKakaoSignUp(_, _):
            return Const.URL.kakaoSignUpURL
        case .postKakaoLogin(_):
            return Const.URL.kakaoLoginURL
        case .postAppleSignUp(_, _):
            return Const.URL.appleSignUpURL
        case .postAppleLogin(_):
            return Const.URL.appleLoginURL
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postKakaoSignUp(_, let nickname):
            return .requestParameters(parameters: [
                "nickname": nickname
            ], encoding: JSONEncoding.default)
            
        case .postKakaoLogin(_):
            return .requestPlain
            
        case .postAppleSignUp(_, let nickname):
            return .requestParameters(parameters: [
                "nickname": nickname
            ], encoding: JSONEncoding.default)
            
        case .postAppleLogin(_):
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .postKakaoSignUp(let idToken, _):
            return [
                "Content-Type": "application/json",
                "idToken": idToken,
                "token": UserDefaults.standard.string(forKey: "fcmToken") ?? ""
            ]
            
        case .postKakaoLogin(let idToken):
            return [
                "Content-Type": "application/json",
                "idToken": idToken,
                "token": UserDefaults.standard.string(forKey: "fcmToken") ?? ""
            ]
            
        case .postAppleSignUp(let idToken, _):
            return [
                "Content-Type": "application/json",
                "idToken": idToken,
                "token": UserDefaults.standard.string(forKey: "fcmToken") ?? ""
            ]
            
        case .postAppleLogin(let idToken):
            return [
                "Content-Type": "application/json",
                "idToken": idToken,
                "token": UserDefaults.standard.string(forKey: "fcmToken") ?? ""
            ]
        }
    }
}
