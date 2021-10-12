//
//  Community.swift
//  Journey
//
//  Created by 초이 on 2021/07/15.
//

import Foundation

// MARK: - FeedResponse

struct FeedResponse: Codable {
    let isNew: Bool
    let hasFeed, userCount: Int
    let feeds: [Feed]
}

// MARK: - Feed
struct Feed: Codable {
    let postID: Int
    let course: String
    let challenge: Int
    let image: String
    let mood: Int
    let content, nickname, year, month: String
    let day, weekday: String
    let emoji: [Emoji]
    let myEmoji: Int
    let isReport, isDelete: Bool

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case course, challenge, image, mood, content, nickname, year, month, emoji, myEmoji, isReport, isDelete
        case day = "date"
        case weekday = "day"
    }
}

// MARK: - Emoji
struct Emoji: Codable {
    let id, count: Int
}
