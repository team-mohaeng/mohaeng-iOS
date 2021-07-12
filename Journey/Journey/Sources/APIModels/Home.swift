//
//  Home.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import Foundation

// MARK: - HomeResponseData
struct HomeResponseData: Codable {
    let status: Int
    let data: HomeData
}

// MARK: - HomeData
struct HomeData: Codable {
    let situation, affinity: Int
    let course: Course
    
    init(situation: Int, affinity: Int, course: Course) {
        self.situation = situation
        self.affinity = affinity
        self.course = course
    }
}
