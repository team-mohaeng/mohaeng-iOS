//
//  Medal.swift
//  Journey
//
//  Created by 초이 on 2021/07/12.
//

import Foundation

// MARK: - MedalData
struct MedalData: Codable {
    let totalIncreasedAffinity, maxSuccessCount: Int
    let courses: [Course]
}

// MARK: - BadgesData
struct BadgesData: Codable {
    let badges: [Badge]
}

// MARK: - Badge
struct Badge: Codable {
    let id: Int
    let name, info, image: String
    let hasBadge: Bool
}
