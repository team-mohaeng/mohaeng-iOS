//
//  Challenge.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import Foundation

// MARK: - Challenge
struct Challenge: Codable {
    let id, situation: Int
    let title, challengeDescription, year, month: String
    let day: String
    let currentStamp, totalStamp: Int
    let userMents: [String]

    enum CodingKeys: String, CodingKey {
        case id, situation, title
        case challengeDescription = "description"
        case year, month, day, currentStamp, totalStamp, userMents
    }
    
    init(id: Int, situation: Int, title: String, challengeDescription: String, year: String, month: String, day: String, currentStamp: Int, totalStamp: Int, userMents: [String]) {
        self.id = id
        self.situation = situation
        self.title = title
        self.challengeDescription = challengeDescription
        self.year = year
        self.month = month
        self.day = day
        self.currentStamp = currentStamp
        self.totalStamp = totalStamp
        self.userMents = userMents
    }
}
