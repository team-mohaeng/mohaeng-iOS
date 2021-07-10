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
        static let baseURL = "http://3.36.55.247:5000/api"
        
        // MARK: - Auth -  Auth Service
        
        // 회원가입 (POST)
        static let signUpURL = "/signup"
        
        // 로그인 (POST)
        static let signInURL = "/signin"
        
        // 비밀번호 찾기 (POST)
        
        // MARK: - HOME - Home Service
        
        // 홈 (GET)
        static let homeURL = "/home"
        
        // MARK: - Challenge
        
        // MARK: - Course Service
        
        // 코스 전체 조회 (GET)
        static let coursesURL = "/courses"
        
        // 코스 진행하기 (PUT) : "/courses/:id"
        
        // MARK: - Challenge Service
        
        // 전체 챌린지 지도 조회 (GET)
        static let challengesURL = "/challenges"
        
        // 오늘의 챌린지 조회 (GET), 챌린지 인증 (PUT) :
        // "/challenges/:courseId/:challengeId
        
        // 완료한 코스 메달 (GET)
        static let medalURL = "/course/complete"
        
        // MARK: - 소확행 - Happy Service
        
        // 소확행 입력(POST), 커뮤니티(GET)
        static let happyURL = "/smallSatisfaction"
        
        // 내 서랍장(GET)
        static let myDrawerURL = "/myDrawer" // "/myDrawer/:month"
        
        // 상세보기(GET), 좋아요(PUT), 좋아요 취소(PUT) : "/smallSatisfaction/:postId"
    }
}
