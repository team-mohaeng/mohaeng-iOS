//
//  Community.swift
//  Journey
//
//  Created by 초이 on 2021/07/15.
//

import Foundation

struct FeedInfo: Codable {
    let isNew: Bool
    let hasFeed, userCount: Int
    let feed: [Feed]
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
        case course, challenge, image, mood, content, nickname, year, month, day, weekday, emoji, myEmoji, isReport, isDelete
    }
}

// MARK: - Emoji
struct Emoji: Codable {
    let emojiID, emojiCount: Int

    enum CodingKeys: String, CodingKey {
        case emojiID = "emojiId"
        case emojiCount
    }
}
