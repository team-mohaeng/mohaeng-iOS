//
//  Notification.swift
//  Journey
//
//  Created by 초이 on 2021/08/30.
//

import Foundation

// MARK: - Notification
struct PushNoti: Codable {
    let profileImg: String
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let date: String
    let message: [String]
    let isNew: Bool
}
