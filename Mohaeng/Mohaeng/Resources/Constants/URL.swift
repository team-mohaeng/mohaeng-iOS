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
        
        // 비밀번호 변경 (PUT)
        static let passwordURL = "/password"

        // 이메일 인증 (GET)
        // "/password/:userId"
        
        // MARK: - HOME - Home Service
        
        // 홈 (GET)
        static let homeURL = "/home"
        
        // MARK: - Challenge
        
        // MARK: - Course Service
        
        // 코스 라이브러리 조회 (GET)
        static let coursesURL = "/courses"
        
        // 코스 진행하기 (PUT) : "/courses/:id"
        
        // 완료한 코스 메달 조회 (GET)
        static let medalURL = "/complete"
        
        // MARK: - Challenge Service
        
        // 전체 챌린지 지도 조회 (GET)
        static let challengesURL = "/challenges"
        
        // 오늘의 챌린지 조회 (GET) :
        // "/challenges/:courseId"
        
        // 챌린지 인증 (PUT)
        // "/challenges/:courseId/:challengeId"
        
        // MARK: - 소확행 - Happy Service
        
        static let happyURL = "/smallSatisfaction"
        
        // 소확행 입력(POST)
        static let writeURL = "/write"
        
        // 소확행 커뮤니티(GET)
        static let feedURL = "/community"
        
        // 소확행 커뮤니티 정렬(좋아요, 최신순) (GET)
        // "/smallStatisfaction/community/:sort"
        
        // 내 서랍장(GET)
        static let myDrawerURL = "/myDrawer" // "/myDrawer/:month"
        
        // 상세보기(GET) : "/smallSatisfaction/detail/:postId"
        static let detailURL = "/detail"
        
        // 좋아요(PUT) : "/smallSatisfaction/like/:postId"
        static let likeURL = "/like"
        
        // 좋아요 취소(PUT) : "/smallSatisfaction/unlike/:postId"
        static let unlikeURL = "/unlike"
        
        static let deleteURL = "/delete"
        
        // 배지 조회 (GET)
        static let badge = "/badge"
    }
}
