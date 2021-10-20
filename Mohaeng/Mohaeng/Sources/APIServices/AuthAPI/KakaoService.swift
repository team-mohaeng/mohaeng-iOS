//
//   KakaoService.swift
//  Mohaeng
//
//  Created by 김승찬 on 2021/10/20.
//

import Foundation
import Moya

enum KakaoService {
    case postKakao

}

extension KakaoService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .postKakao:
            return Const.URL.kakaoURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postKakao:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .postKakao:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
        ]
    }
}
