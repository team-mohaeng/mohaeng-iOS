//
//  Course.swift
//  Journey
//
//  Created by 초이 on 2021/06/30.
//

import Foundation

struct Course {
    let id: Int
    let title: String
    let description: String
    let courseDays: Int
    let situation: Int
    let property: String
    
    init(id: Int, title: String, description: String, courseDays: Int, situation: Int, property: String) {
        self.id = id
        self.title = title
        self.description = description
        self.courseDays = courseDays
        self.situation = situation
        self.property = property
    }
}
