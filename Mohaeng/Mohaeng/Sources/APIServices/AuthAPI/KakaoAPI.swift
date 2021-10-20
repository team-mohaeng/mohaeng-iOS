//
//  KakaoAPI.swift
//  Mohaeng
//
//  Created by 김승찬 on 2021/10/20.
//

import Foundation
import Moya

public class KakaoAPI {
    
    static let shared = KakaoAPI()
    var kakaoProvider = MoyaProvider<KakaoService>()
    
    private init() {}
    
    func postKakao(token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        kakaoProvider.request(.postKakao(token: token)) { (result) in
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postSocialNickname(completion: @escaping (NetworkResult<Any>) -> Void, token: String, nickname: String) {
        kakaoProvider.request(.socialNickname(token: token, nickname: nickname)) { (result) in
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // MARK: - judging status function
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
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
}
