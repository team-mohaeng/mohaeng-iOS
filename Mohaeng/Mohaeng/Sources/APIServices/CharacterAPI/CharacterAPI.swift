//
//  CharacterAPI.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/10/17.
//

import Foundation
import Moya

public class CharacterAPI {
    
    static let shared = CharacterAPI()
    var characterProvider = MoyaProvider<CharacterService>()
    
    public init() { }
    
    enum ResponseData {
        case getCharacter
        case putCharacter
    }
    
    func getCharacterInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        characterProvider.request(.getCharacter) { (result) in
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getCharacter)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func putCharacterStyle(data: CharacterStyleReqeust, _ completion: @escaping (NetworkResult<Any>) -> Void) {
        characterProvider.request(.putCharacter(data: data)) { result in
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .putCharacter)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            switch responseData {
            case .getCharacter, .putCharacter:
                return isValidData(data: data, responseData: responseData)
            }
        case 400..<500:
            return .requestErr(data)
        case 500:
            print(data)
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData(data: Data, responseData: ResponseData) -> NetworkResult<Any> {
            let decoder = JSONDecoder()
            
            switch responseData {
            case .getCharacter:
                guard let decodedData = try? decoder.decode(GenericResponse<CharacterStyle>.self, from: data) else {
                    return .pathErr
                }
                return .success(decodedData.data)
            case .putCharacter:
                guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data) else {
                    return .pathErr
                }
                return .success(decodedData.message)
            }
        }
}
