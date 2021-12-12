//
//  Course.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import Foundation

// MARK: - CourseData
struct CourseData: Codable {
    let isComplete, isPenalty: Bool
    let mainCharacterImg, popupCharacterImg: String
    let course: TodayChallengeCourse
}
