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
    case getAllFeed
    case getMyDrawer(year: Int, month: Int)
    case postFeed(content: String, mood: Int, isPrivate: Bool, image: UIImage?)
    case postReport(id: Int)
    case putEmoji(emojiId: Int, postId: Int)
    case deletePost(postId: Int)
}

extension FeedService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getAllFeed, .postFeed:
            return Const.URL.feedURL
        case .getMyDrawer(let year, let month):
            return Const.URL.feedURL + "/\(year)" + "/\(month)"
        case .postReport(let id):
            return Const.URL.feedURL + "/\(id)"
        case .putEmoji(_, let postId):
            return Const.URL.feedURL + Const.URL.emojiURL + "/\(postId)"
        case .deletePost(let postId):
            return Const.URL.feedURL + "/\(postId)"
        }
    
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllFeed, .getMyDrawer:
            return .get
        case .postFeed, .postReport:
            return .post
        case .putEmoji:
            return .put
        case .deletePost:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAllFeed, .getMyDrawer, .postReport, .deletePost:
            return .requestPlain
        case .putEmoji(let emojiId, _):
            return .requestParameters(parameters: ["emojiId" : emojiId], encoding: JSONEncoding.default)
        case .postFeed(let content, let mood, let isPrivate, let image):
            var multiPartFormData: [MultipartFormData] = []
            let json: [String: Any] = [
                "content": content,
                "mood": mood,
                "isPrivate": isPrivate
            ]

            let jsondata = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            guard let data = jsondata else { return .uploadMultipart([]) }

            let jsonString = String(data: data, encoding: .utf8)!
            let multipartData = MultipartFormData(provider: .data(jsonString.data(using: String.Encoding.utf8)!), name: "feed")
            multiPartFormData.append(multipartData)
            
            if let image = image,
               let imageData = image.jpegData(compressionQuality: 1.0) {
                let imgData = MultipartFormData(provider: .data(imageData), name: "image", fileName: "image", mimeType: "image/jpeg")
                multiPartFormData.append(imgData)
            }

            return .uploadMultipart(multiPartFormData)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getAllFeed, .getMyDrawer, .postReport, .putEmoji, .deletePost:
            return [
                "Content-Type": "application/json",
                "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
            ]
        case .postFeed:
            return [
                "Content-Type": "multipart/form-data",
                "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
            ]
        
        }
    }
    
}
