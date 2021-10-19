//
//  CharacterService.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/10/17.
//

import Foundation
import Moya

enum CharacterService {
    case getCharacter
    case putCharacter(data: CharacterStyleReqeust)
}

extension CharacterService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getCharacter:
            return Const.URL.characterURL + "/ios"
        case .putCharacter:
            return Const.URL.characterURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCharacter:
            return .get
        case .putCharacter:
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCharacter:
            return .requestPlain
        case .putCharacter(let data):
            return .requestParameters(parameters: ["characterSkin": data.characterSkin,
                                                   "characterType": data.characterType,
                                                   "characterCard": data.characterCard]
            , encoding: JSONEncoding.default)
            
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
        ]
    }
        
}
