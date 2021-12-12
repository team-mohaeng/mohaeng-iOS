//
//  PushNotiAPI.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/17.
//

import Foundation
import Moya

public class PushNotiAPI {
    
    static let shared = PushNotiAPI()
    var pushNotiProvider = MoyaProvider<PushNotiService>()
    
    public init() { }
    
    func getNotifications(completion: @escaping (NetworkResult<Any>) -> Void) {
        pushNotiProvider.request(.getNotifications) { (result) in
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
            guard let decodedData = try? decoder.decode(GenericResponse<PushNoti>.self, from: data)
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
