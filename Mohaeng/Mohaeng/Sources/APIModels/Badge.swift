//
//  BadgesData.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/08.
//

import Foundation

// MARK: - BadgesData
struct BadgesData: Codable {
    let badges: [Badge]

}

// MARK: - Badge
struct Badge: Codable {
    let id: Int
    let name, info: String
    let image: String?
    let hasBadge: Bool

}
