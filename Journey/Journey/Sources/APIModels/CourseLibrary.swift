//
//  CourseLibrary.swift
//  Journey
//
//  Created by 초이 on 2021/09/08.
//

import Foundation

// MARK: - CourseLibraryData
struct CourseLibraryData: Codable {
    let isProgress: Bool
    let courses: [CourseLibrary]
}

// MARK: - CourseLibrary
struct CourseLibrary: Codable {
    let id, situation, property: Int
    let title, courseDescription: String
    let totalDays: Int

    enum CodingKeys: String, CodingKey {
        case id, situation, property, title
        case courseDescription
        case totalDays
    }
}
