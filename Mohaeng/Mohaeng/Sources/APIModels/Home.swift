//
//  Home.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import Foundation

// MARK: - Home

struct Home: Codable {
    let nickname, level: String
    let happy, fullHappy: Int
    let characterLottie, characterSkin: String
    let isStyleNew, isBadgeNew: Bool
    let course: CourseInfo
}

// MARK: - Course
struct CourseInfo: Codable {
    let challengeTitle: String
    let percent: Int
}
