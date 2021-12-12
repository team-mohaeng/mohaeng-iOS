//
//  ChallengeAPI.swift
//  Journey
//
//  Created by 초이 on 2021/07/10.
//

import Foundation
import Moya

public class ChallengeAPI {
    
    static let shared = ChallengeAPI()
    var challengeProvider = MoyaProvider<ChallengeService>()
    
    public init() { }
    
    func getAllChallenges(completion: @escaping (NetworkResult<Any>) -> Void) {
        challengeProvider.request(.getAllChallenges) { (result) in
            
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeGetAllChallengeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    func putTodayChallenge(completion: @escaping (NetworkResult<Any>) -> Void, courseId: Int, challengeId: Int) {
        challengeProvider.request(.putTodayChallenge(courseId: courseId, challengeId: challengeId)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgePutTodayChallengeStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
        
    }
    
    // MARK: - judging status function
    
    private func judgeGetAllChallengeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<TodayChallengeData>.self, from: data) else {
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
    
    private func judgePutTodayChallengeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(GenericResponse<CompletedChallengeData>.self, from: data) else {
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
