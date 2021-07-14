//
//  Community.swift
//  Journey
//
//  Created by 초이 on 2021/07/15.
//

import Foundation

// MARK: - Community
struct Community: Codable {
    let postID: Int
    let nickname: String
    let mood: Int
    let mainImage: String
    let likeCount: Int
    let content: String
    let hasLike: Bool
    let hashtags: [String]
    let year, month, day, week: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case nickname, mood, mainImage, likeCount, content, hasLike, hashtags, year, month, day, week
    }
}
