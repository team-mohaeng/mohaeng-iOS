//
//  MyPage.swift
//  Mohaeng
//
//  Created by 초이 on 2021/09/27.
//

import Foundation

// MARK: - MyPage

struct MyPage: Codable {
    let nickname: String
    let email: String
    let completeCourseCount: Int
    let completeChallengeCount: Int
    let feedCount: Int
    let badgeCount: Int
    let calendar: [MyPageCalendar]
}

// MARK: - Calendar

struct MyPageCalendar: Codable {
    let property: Int
    let date: [String]
}
