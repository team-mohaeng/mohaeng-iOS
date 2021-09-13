//
//  Home.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import Foundation

// MARK: - HomeData
struct HomeData: Codable {
    let situation, affinity: Int
    var course: Course?
    
    enum CodingKeys: String, CodingKey {
        case situation, affinity, course
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.situation = (try? values.decode(Int.self, forKey: .situation)) ?? 0
        self.affinity = (try? values.decode(Int.self, forKey: .affinity)) ?? 0
        self.course = (try? values.decode(Course.self, forKey: .course)) ?? nil
    }
}
