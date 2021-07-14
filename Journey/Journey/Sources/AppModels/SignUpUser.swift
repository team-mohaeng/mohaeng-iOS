//
//  SignUpUser.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/14.
//

import Foundation

class SignUpUser {
    static let shared = SignUpUser()
    var email: String?
    var password: String?
    var nickname: String?
    var gender: Int?
    var birthyear: Int?
}
