//
//  KakaoAPI.swift
//  Mohaeng
//
//  Created by 김승찬 on 2021/10/20.
//

import Foundation
import Moya

public class SocialAPI {
    
    static let shared = SocialAPI()
    var socialProvider = MoyaProvider<SocialService>()
    
    private init() {}
    
    func postKakaoSignUp(idToken: String, nickname: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        socialProvider.request(.postKakaoSignUp(idToken: idToken, nickname: nickname)) { (result) in
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeSignUpStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postAppleSignUp(idToken: String, nickname: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        socialProvider.request(.postAppleSignUp(idToken: idToken, nickname: nickname)) { (result) in
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeSignUpStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postKakaoLogin(idToken: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        socialProvider.request(.postKakaoLogin(idToken: idToken)) { (result) in
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeLoginStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postAppleLogin(idToken: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        socialProvider.request(.postAppleLogin(idToken: idToken)) { (result) in
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeLoginStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // MARK: - judging status function
    
    private func judgeSignUpStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<JwtData>.self, from: data) else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeLoginStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<SocialLoginData>.self, from: data) else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
