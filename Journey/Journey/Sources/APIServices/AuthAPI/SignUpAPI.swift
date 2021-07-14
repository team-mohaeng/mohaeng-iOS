//
//  SignUpAPI.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/14.
//

import Foundation
import Moya

public class SignUpAPI {
    
    static let shared = SignUpAPI()
    var signupProvider = MoyaProvider<SignUpService>()
    
    enum  ResponseData {
        case jwt
    }
    
    public init() { }
    
    func postSignUp(completion: @escaping (NetworkResult<Any>) -> Void, email: String, password: String, nickname: String, gender: Int, birthyear: Int) {
        signupProvider.request(.postSignUp(email: email, password: password, nickname: nickname, gender: gender, birthyear: birthyear)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .jwt)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            return isValidData(data: data, responseData: responseData)
        case 400..<500:
            print(statusCode)
            return .requestErr(data)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData(data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        switch responseData {
        case .jwt:
            guard let decodedData = try? decoder.decode(JwtResponseData.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.data)
        }
    }
}
