//
//  Home.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import Foundation

struct Home: Codable {
    let situation, affinity: Int
    let courses: [Course]
    
    init(situation: Int, affinity: Int, courses: [Course]) {
        self.situation = situation
        self.affinity = affinity
        self.courses = courses
    }
}
