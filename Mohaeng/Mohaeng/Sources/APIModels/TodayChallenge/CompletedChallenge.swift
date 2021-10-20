//
//  CompletedChallenge.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/19.
//

import Foundation

// MARK: - CompletedChallengeData
struct CompletedChallengeData: Codable {
    let characterImg: String
    let challengeCompletion: ChallengeCompletion
    let courseCompletion: CourseCompletion
    let levelUp: CompletionLevelUp
}

// MARK: - ChallengeCompletion
struct ChallengeCompletion: Codable {
    let happy, userHappy, fullHappy: Int
    let isPenalty: Bool
}

// MARK: - CourseCompletion
struct CourseCompletion: Codable {
    let property: Int?
    let title: String?
    let happy, userHappy, fullHappy: Int?
}

// MARK: - CompletionLevelUp
struct CompletionLevelUp: Codable {
    let level: Int?
    let styleImg: String?
}
