//
//  FeedService.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/13.
//

import Foundation
import Moya

enum FeedService {
    case getMyDrawer(year: String, month: String)
    case getFeedDetail(postId: Int)
    case getAllFeed(sort: String)
    case postFeedContents(moodImage: String, moodText: String, content: String, hashtags: [String], mainImage: String, isPrivate: Bool)
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
            return Const.URL.happyURL + "/\(postId)"
        case .getAllFeed(let sort):
            return Const.URL.happyURL + Const.URL.feedURL + "/\(sort)"
        case .postFeedContents(_, _, _, _, _, _):
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
        case .postFeedContents(_, _, _, _, _, _):
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
        case .postFeedContents(let moodImage, let moodText, let content, let hashtags, let mainImage, let isPrivate):
            return .requestParameters(parameters: [
                "moodImage": moodImage,
                "moodText": moodText,
                "content": content,
                "hashtags": hashtags,
                "mainImage": mainImage,
                "isPrivate": isPrivate
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
            "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
        ]
    }
    
}
