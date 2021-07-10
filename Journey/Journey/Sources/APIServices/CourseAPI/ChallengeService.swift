//
//  ChallengeService.swift
//  Journey
//
//  Created by 초이 on 2021/07/10.
//

import Foundation
import Moya

let testToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiZXA0UmhZcmJUSE9uaHpBUldOVFNTMTpBUEE5MWJIS1pGdkJuUkV1dEEtYzQxSmN6dDBITzVJQkNyMFhzM0VadjFFcUZSVl9jY05semtDbFQtaWxmT3FGTUFWTmFPUFYxaVhIQjIybHhrcHZJRWNTNW4tMjQtZzY2SVR1d0o1aW9aWlJtYVd5R1Q3XzZiUDhlR1BOZHd2SkNwUWxZb1daQlhHVCJ9LCJpYXQiOjE2MjU4OTgzMjF9.R2NjbrV_wPeTNaoyQu9yhcbc0sPTqRrEC-pRngcFn1M"

enum ChallengeService {
    // 전체 챌린지 지도 조회
    case getAllChallenges
    // 오늘의 챌린지 조회
    case getTodayChallenge(courseId: String, challengeId: String)
    // 챌린지 인증
    case putTodayChallenge(courseId: String, challengeId: String)
    // 완료한 코스 메달
    case getMedal
}

extension ChallengeService: TargetType {
    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        // 전체 챌린지 지도 조회
        case .getAllChallenges:
            return Const.URL.challengesURL
        // 오늘의 챌린지 조회
        case .getTodayChallenge(let courseId, let challengeId):
            return Const.URL.challengesURL + "/\(courseId)/\(challengeId)"
        // 챌린지 인증
        case .putTodayChallenge(let courseId, let challengeId):
            return Const.URL.challengesURL + "/\(courseId)/\(challengeId)"
        // 완료한 코스 메달
        case .getMedal:
            return Const.URL.medalURL
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        // 전체 챌린지 지도 조회
        case .getAllChallenges:
            return .get
        // 오늘의 챌린지 조회
        case .getTodayChallenge(_, _):
            return .get
        // 챌린지 인증
        case .putTodayChallenge(_, _):
            return .put
        // 완료한 코스 메달
        case .getMedal:
            return .get
        }
    }
    
    var sampleData: Data {
        // TODO: - Unit test 를 위한 Sample data 집어넣기
        
        // 임시 기본 sample data
        return Data()
    }
    
    var task: Task {
        switch self {
        // params가 없는 API - .requestPlain
        case .getAllChallenges, .getMedal, .getTodayChallenge(_, _), .putTodayChallenge(_, _):
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Bearer": testToken
        ]
    }
}
