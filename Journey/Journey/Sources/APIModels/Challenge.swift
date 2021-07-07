//
//  Challenge.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import Foundation

struct Challenge: Codable {
    let id, situation: Int
    let challengeDescription, year, month, day: String
    let currentStamp, totalStamp: Int
    let userMents: [String]

    enum CodingKeys: String, CodingKey {
        case id, situation
        case challengeDescription = "description"
        case year, month, day, currentStamp, totalStamp, userMents
    }
    
    init(id: Int, situation: Int, challengeDescription: String, year: String, month: String, day: String, currentStamp: Int, totalStamp: Int, userMents: [String]) {
        self.id = id
        self.situation = situation
        self.challengeDescription = challengeDescription
        self.year = year
        self.month = month
        self.day = day
        self.currentStamp = currentStamp
        self.totalStamp = totalStamp
        self.userMents = userMents
    }
}

