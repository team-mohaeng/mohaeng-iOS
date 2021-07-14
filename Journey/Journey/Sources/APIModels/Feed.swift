//
//  Feed.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/13.
//

import Foundation

// MARK: - FeedResponseData
struct FeedResponseData: Codable {
    let status: Int
    let data: FeedData
}

// MARK: - FeedData
struct FeedData: Codable {
    let hasSmallSatisfaction, userCount: Int

    let community: [Community]
}

// MARK: - Community
struct Community: Codable {
    let postID: Int
    let nickname: String
    let moodImage, mainImage: String
    let likeCount: Int
    let content: String
    let hasLike: Bool
    let hashtags: [String]
    let year, month, day: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case nickname, moodImage, mainImage, likeCount, content, hasLike, hashtags, year, month, day
    }
}
