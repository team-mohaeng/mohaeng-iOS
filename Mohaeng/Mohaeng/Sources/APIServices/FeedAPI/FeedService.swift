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
}

extension FeedService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getAllFeed:
            return Const.URL.feedURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllFeed:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAllFeed:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getAllFeed:
            return [
                "Content-Type": "application/json",
                "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
            ]
        }
    }
    
}
