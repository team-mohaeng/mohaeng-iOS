//
//  CourseHistory.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/17.
//

import Foundation

// 커밋하기 전에 지워야 함

// MARK: - CourseHistoryData
struct CourseHistoryData: Codable {
    let courses: [Course]
}

// MARK: - CourseHistory
struct CourseHistory: Codable {
    let id, situation, property: Int
    let title: String
    let totalDays: Int
    let year, month, date: String
    let challenges: [ChallengeHistory]
}

// MARK: - Challenge
struct ChallengeHistory: Codable {
    let day, situation: Int
    let title, year, month, date: String
}
