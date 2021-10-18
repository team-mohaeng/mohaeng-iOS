//
//  FeedAPI.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/13.
//

import Foundation
import Moya

public class FeedAPI {
    
    static let shared = FeedAPI()
    var feedProvider = MoyaProvider<FeedService>()
    
    enum ResponseData {
        case feed
        case writing
    }
    
    public init() { }
    
    func getAllFeed(completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.getAllFeed) { (result) in
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .feed)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postFeed(writingRequest: WritingRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.postFeed(content: writingRequest.content,
                                       mood: writingRequest.mood,
                                       isPrivate: writingRequest.isPrivate,
                                       image: writingRequest.image)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .writing)
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
            case .feed, .writing:
                return isValidData(data: data, responseData: responseData)
            }
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
        case .feed:
            guard let decodedData = try? decoder.decode(GenericResponse<FeedResponse>.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.data)
        case .writing:
            guard let decodedData = try? decoder.decode(GenericResponse<WritingResponse>.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.data)
        }
    }
}
