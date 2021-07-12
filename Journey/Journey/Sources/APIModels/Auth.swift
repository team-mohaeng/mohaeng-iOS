//
//  User.swift
//  Journey
//
//  Created by 초이 on 2021/07/07.
//

import Foundation

// 로그인, 회원가입, 비밀번호 찾기

// MARK: - jwtResponseModel
struct JwtResponseData: Codable {
    let status: Int
    let data: JwtData
}

// MARK: - jwtData
struct JwtData: Codable {
    let jwt: String
}

// 이메일 인증

// MARK: - Welcome
struct CodeResponseData: Codable {
    let status: Int
    let data: CodeData
}

// MARK: - DataClass
struct CodeData: Codable {
    let number: Int
}

