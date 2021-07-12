//
//  Medal.swift
//  Journey
//
//  Created by 초이 on 2021/07/12.
//

import Foundation

// MARK: - MedalResponseData
struct MedalResponseData: Codable {
    let status: Int
    let data: MedalData
}

// MARK: - MedalData
struct MedalData: Codable {
    let totalIncreasedAffinity, maxSuccessCount: Int
    let courses: [Course]
}
