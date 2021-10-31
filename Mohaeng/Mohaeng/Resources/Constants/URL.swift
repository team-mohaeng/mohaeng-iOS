//
//  URL.swift
//  Journey
//
//  Created by 초이 on 2021/07/06.
//

import Foundation

extension Const {
    struct URL {
        
        // base url
        static let baseURL = "http://54.180.103.98:5000/api"
        
        // MARK: - Auth -  Auth Service
        
        // 회원가입 (POST)
        static let signUpURL = "/signup"
        
        // 로그인 (POST)
        static let signInURL = "/signin"
        
        // 키카오 (POST)
        static let kakaoLoginURL = "/kakao"
        static let kakaoSignUpURL = "/kakao/signup"
        
        // 애플 (POST)
        static let appleLoginURL = "/apple"
        static let appleSignUpURL = "/apple/signup"
        
        // 비밀번호 변경 (PUT)
        static let passwordURL = "/password"

        // 이메일 인증 (GET)
        // "/password/:userId"
        
        // MARK: - HOME - Home Service
        
        // 홈 (GET)
        static let homeURL = "/home"
        static let characterURL = "/character"
        
        // MARK: - Challenge
        
        // MARK: - Course Service
        
        // 코스 라이브러리 조회 (GET)
        static let coursesURL = "/courses"
        
        // 코스 진행하기 (PUT) : "/courses/:id"
        
        // 완료한 코스 기록 조회 (GET)
        static let courseHistoryURL = "/courses/complete"
        
        // MARK: - Challenge Service
        
        // 전체 챌린지 지도 조회 (GET), 오늘의 챌린지 조회 (GET)
        static let challengesURL = "/today"
        
        // 챌린지 인증 (PUT)
        // "/today/:courseId/:challengeId"
        
        // MARK: - 피드 커뮤니티(GET)
        
        static let feedURL = "/feed"
        static let emojiURL = "/emoji"
    
        
        // 배지 조회 (GET)
        static let badge = "/badge"
        
        // MARK: - 푸쉬 알림 (채팅 뷰)
        
        static let notification = "/message"
      
        // MARK: - 마이페이지
        
        static let myPage = "/profile"
    }
}
