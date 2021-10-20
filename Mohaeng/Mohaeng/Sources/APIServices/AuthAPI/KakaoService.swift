//
//   KakaoService.swift
//  Mohaeng
//
//  Created by 김승찬 on 2021/10/20.
//

import Foundation
import Moya

enum KakaoService {
    case postKakao(token: String)
    case socialNickname(token: String, nickname: String)

}

extension KakaoService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .postKakao(_):
            return Const.URL.kakaoURL
        case .socialNickname(_, _):
            return Const.URL.socialNickname
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postKakao(_):
            return .post
        case .socialNickname(_, _):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postKakao(_):
            return .requestPlain
        case .socialNickname(_, let nickname):
            return .requestParameters(parameters: [
                "nickname": nickname
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .postKakao(let token):
            return [
                "Bearer": token
            ]
        case .socialNickname(let token, _):
            return [
                 "Content-Type": "application/json",
                 "token": token
            ]
        }
    }
}
