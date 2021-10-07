//
//  BadgeAPI.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/08.
//

import Foundation
import Moya

public class BadgeAPI {
    
    static let shared = BadgeAPI()
    var badgeProvider = MoyaProvider<BadgeService>()
    
    private init() {}
    
    func getBadges(completion: @escaping (NetworkResult<Any>) -> Void) {
        badgeProvider.request(.getBadges) { (result) in
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
        
        guard let decodedData = try? decoder.decode(BadgesData.self, from: data) else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.badges)
        case 400..<500:
            return .requestErr(decodedData)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
