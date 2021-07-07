//
//  User.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import Foundation

struct User: Codable {
    let jwt: String
    
    init(jwt: String) {
        self.jwt = jwt
    }
}
