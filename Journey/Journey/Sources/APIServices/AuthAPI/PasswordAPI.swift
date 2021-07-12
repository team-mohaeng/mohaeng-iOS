//
//  PasswordAPI.swift
//  Journey
//
//  Created by 초이 on 2021/07/12.
//

import Foundation
import Moya

public class PasswordAPI {
    
    static let shared = PasswordAPI()
    var courseProvider = MoyaProvider<PasswordService>()
    
    enum ResponseData {
        case jwt
        case code
    }
    
    public init() { }
    
    func putNewPassword(completion: @escaping (NetworkResult<Any>) -> Void, email: String, password: String) {
        courseProvider.request(.putChangedPassword(email: email, password: password)) { (result) in
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
    
    func getEmailCode(completion: @escaping (NetworkResult<Any>) -> Void, email: String) {
        courseProvider.request(.getEmailCode(email: email)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .code)
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
        case .code:
            guard let decodedData = try? decoder.decode(CodeResponseData.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.data)
        }
    }
}
