//
//  User.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import Foundation

// 로그인, 회원가입, 비밀번호 찾기

// MARK: - jwtData
struct JwtData: Codable {
    let jwt: String
}

// MARK: - SocialLoginData
struct SocialLoginData: Codable {
    let user: Bool
    let jwt: String
}

// 이메일 인증

// MARK: - DataClass
struct CodeData: Codable {
    let number: Int
}

// MARK: - message
struct EmailCheckData: Codable {
    let message: String
}
