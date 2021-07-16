//
//  Writing.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/16.
//

import Foundation

// MARK: - Welcome
struct WritingResponseData: Codable {
    let status: Int
    let data: Image
}

// MARK: - DataClass
struct Image: Codable {
    let image: String
}
