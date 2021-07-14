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
        case community
        case statusCode
    }
    
    public init() { }
    
    func getAllFeed(sort: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.getAllFeed(sort: sort)) { (result) in
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .community)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func putFeedLike(postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.putFeedLike(postId: postId)) { (result) in
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .statusCode)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func putFeedUnlike(postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.putFeedUnlike(postId: postId)) { (result) in
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .statusCode)
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
            case .community:
                return isValidData(data: data, responseData: responseData)
            case .statusCode:
                return .success(statusCode)
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
        
        guard let decodedData = try? decoder.decode(FeedResponseData.self, from: data) else {
            return .pathErr
        }
        
        return .success(decodedData.data)
    }
}
