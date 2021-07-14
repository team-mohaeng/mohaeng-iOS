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
