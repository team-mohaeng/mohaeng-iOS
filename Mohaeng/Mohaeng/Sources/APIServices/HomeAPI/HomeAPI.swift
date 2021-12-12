//
//  HomeAPI.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/12.
//

import Foundation
import Moya

public class HomeAPI {
    
    static let shared = HomeAPI()
    var homeProvider = MoyaProvider<HomeService>()
    
    public init() { }
    
    func getHomeInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.getHomeInfo) { (result) in
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(GenericResponse<Home>.self, from: data)
            else {
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
