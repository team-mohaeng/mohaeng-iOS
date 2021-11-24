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
        case myDrawer
        case report
        case emoji
        case delete
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
    
    func getMyDrawer(year: Int, month: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.getMyDrawer(year: year, month: month)) { result in
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
    
    func postReport(id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.postReport(id: id)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .report)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postBlock(nickname: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.postBlock(nickname: nickname)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .report)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postEmoji(emojiId: Int, postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.putEmoji(emojiId: emojiId, postId: postId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .emoji)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func deleteMyPost(postId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        feedProvider.request(.deletePost(postId: postId)) { result in
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
        case 200, 400..<500:
            switch responseData {
            case .feed, .writing, .myDrawer, .report, .emoji, .delete:
                return isValidData(data: data, responseData: responseData)
            }
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
        case .myDrawer:
            guard let decodedData = try? decoder.decode(GenericResponse<FeedResponse>.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.data?.feeds)
        case .report, .emoji, .delete:
            guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData.message)
        }
    }
}
