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
