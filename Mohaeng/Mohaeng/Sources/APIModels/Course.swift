//
//  Course.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import Foundation

// MARK: - CourseData
struct CourseData: Codable {
    let course: Course
}

// MARK: - CoursesData
struct CoursesData: Codable {
    let courses: [Course]
}

// MARK: - Course
struct Course: Codable {
    let id, situation: Int
    let title, courseDescription: String
    let totalDays: Int
    let property: Int
    let challenges: [Challenge]

    enum CodingKeys: String, CodingKey {
        case id, situation, title
        case courseDescription = "description"
        case totalDays, property, challenges
    }
    
    init(id: Int, title: String, courseDescription: String, totalDays: Int, situation: Int, property: Int, challenges: [Challenge]) {
        self.id = id
        self.situation = situation
        self.title = title
        self.courseDescription = courseDescription
        self.totalDays = totalDays
        self.property = property
        self.challenges = challenges
    }
}
