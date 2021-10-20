//
//  TodayChallenge.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/17.
//

import Foundation

// MARK: - TodayChallengeData
struct TodayChallengeData: Codable {
    let isComplete: Bool
    let mainCharacterImg, popupCharacterImg: String
    let course: TodayChallengeCourse
}

// MARK: - TodayChallengeCourse
struct TodayChallengeCourse: Codable {
    let id: Int
    let situation: Int
    let property: Int
    let title: String
    let totalDays: Int
    let currentDay: Int
    let year: String
    let month: String
    let date: String
    var challenges: [TodayChallenge]
}

// MARK: - TodayChallengeChallenge
struct TodayChallenge: Codable {
    let day, situation: Int
    let title: String
    let happy: Int
    let beforeMent, afterMent, year, month: String
    let date: String
    let badges: [String]
}
