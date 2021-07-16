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
        case myDrawer
        case feedDetail
        case statusCode
        case delete
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
    
    func getFeedDetail(postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.getFeedDetail(postId: postId)) { (result) in
            switch result {
            case .success(let response) :
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .feedDetail)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getMyDrawer(year: String, month: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.getMyDrawer(year: year, month: month)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .myDrawer)
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
    
    func deleteFeed(postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.deleteFeed(postId: postId)) { (result) in
            switch result {
            case .success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .delete)
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
            case .myDrawer:
                return isValidData(data: data, responseData: responseData)
            case .feedDetail:
                return isValidData(data: data, responseData: responseData)
            case .delete:
                return .success(statusCode)
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
        
        switch responseData {
        case .community:
            guard let decodedData = try? decoder.decode(FeedResponseData.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.data)
        case .myDrawer:
            guard let decodedData = try? decoder.decode(MyDrawerResponseData.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.data)
        case .feedDetail:
            guard let decodedData = try? decoder.decode(FeedDetailResonpseData.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.data)
        default:
            return .pathErr
        }
    }
}
