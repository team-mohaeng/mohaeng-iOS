//
//  Writing.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/16.
//

import UIKit

// MARK: - WritingRequest
struct WritingRequest {
    var content: String
    var mood: Int
    var isPrivate: Bool
    var image: UIImage?
}

// MARK: - WritingResponse
struct WritingResponse: Codable {
    let happy, userHappy, totalHappy: Int
    let isPenalty: Bool
    let levelUp: LevelUp
}

// MARK: - LevelUp
struct LevelUp: Codable {
    let level: Int?
    let styleImg: String?
}
