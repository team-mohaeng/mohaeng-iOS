//
//  FeedService.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/13.
//

import Foundation
import UIKit
import Moya

enum FeedService {
    case getMyDrawer(year: String, month: String)
    case getFeedDetail(postId: Int)
    case getAllFeed(sort: String)
    case postFeedContents(mood: Int, content: String, hashtags: [String], mainImage: UIImage?, isPrivate: Bool)
    case postFeedContentsWithoutImage(mood: Int, content: String, hashtags: [String], isPrivate: Bool)
    case putFeedLike(postId: Int)
    case putFeedUnlike(postId: Int)
}

extension FeedService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getMyDrawer(let year, let month):
            return Const.URL.happyURL + Const.URL.myDrawerURL + "/\(year)/\(month)"
        case .getFeedDetail(let postId):
            return Const.URL.happyURL + Const.URL.detailURL + "/\(postId)"
        case .getAllFeed(let sort):
            return Const.URL.happyURL + Const.URL.feedURL + "/\(sort)"
        case .postFeedContentsWithoutImage(_, _, _, _):
            return Const.URL.happyURL + Const.URL.writeURL
        case .postFeedContents(_, _, _, _, _):
            return Const.URL.happyURL + Const.URL.writeURL
        case .putFeedLike(let postId):
            return Const.URL.happyURL + Const.URL.likeURL + "/\(postId)"
        case .putFeedUnlike(let postId):
            return Const.URL.happyURL + Const.URL.unlikeURL + "/\(postId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyDrawer(_, _):
            return .get
        case .getFeedDetail(_):
            return .get
        case .getAllFeed(_):
            return .get
        case .postFeedContentsWithoutImage(_, _, _, _):
            return .post
        case .postFeedContents(_, _, _, _, _):
            return .post
        case .putFeedLike(_):
            return .put
        case .putFeedUnlike(_):
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAllFeed(_), .getMyDrawer(_, _), .getFeedDetail(_), .putFeedUnlike(_), .putFeedLike(_):
            return .requestPlain
        case .postFeedContents(let mood, let content, let hashtags, let mainImage, let isPrivate):
            var multiPartFormData: [MultipartFormData] = []
            let json: [String: Any] = [
                "mood": mood,
                "content": content,
                "hashtags": hashtags,
                "isPrivate": isPrivate
            ]
            
            let jsondata = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let data = jsondata else { return .uploadMultipart([]) }
            
            let jsonString = String(data: data, encoding: .utf8)!
            let multipartData = MultipartFormData(provider: .data(jsonString.data(using: String.Encoding.utf8)!), name: "smallSatisfaction")
            multiPartFormData.append(multipartData)

            let imageData = mainImage!.jpegData(compressionQuality: 1.0)
            let imgData = MultipartFormData(provider: .data(imageData!), name: "mainImage", fileName: "image", mimeType: "image/jpeg")
            multiPartFormData.append(imgData)
            
            return .uploadMultipart(multiPartFormData)
        case .postFeedContentsWithoutImage(let mood, let content, let hashtags, let isPrivate):
            var multiPartFormData: [MultipartFormData] = []
            let json: [String: Any] = [
                "mood": mood,
                "content": content,
                "hashtags": hashtags,
                "isPrivate": isPrivate
            ]

            let jsondata = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let data = jsondata else { return .uploadMultipart([]) }
            let jsonString = String(data: data, encoding: .utf8)!
            
            let multipartData = MultipartFormData(provider: .data(jsonString.data(using: String.Encoding.utf8)!), name: "smallSatisfaction")
            multiPartFormData.append(multipartData)
            
            return .uploadMultipart(multiPartFormData)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postFeedContents(_, _, _, _, _):
            return [
                "Content-Type": "multipart/form-data",
                "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
            ]
        }
    }
    
}
