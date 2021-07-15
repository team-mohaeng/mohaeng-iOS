//
//  ChallengeService.swift
//  Journey
//
//  Created by 초이 on 2021/07/10.
//

import Foundation
import Moya

enum ChallengeService {
    // 전체 챌린지 지도 조회
    case getAllChallenges
    // 오늘의 챌린지 조회
    case getTodayChallenge(courseId: Int)
    // 챌린지 인증
    case putTodayChallenge(courseId: Int, challengeId: Int)
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
        case .getTodayChallenge(let courseId):
            return Const.URL.challengesURL + "/\(courseId)"
        // 챌린지 인증
        case .putTodayChallenge(let courseId, let challengeId):
            return Const.URL.challengesURL + "/\(courseId)/\(challengeId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        // 전체 챌린지 지도 조회
        case .getAllChallenges:
            return .get
        // 오늘의 챌린지 조회
        case .getTodayChallenge(_):
            return .get
        // 챌린지 인증
        case .putTodayChallenge(_, _):
            return .put
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
        case .getAllChallenges, .getTodayChallenge(_), .putTodayChallenge(_, _):
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Bearer": UserDefaults.standard.string(forKey: "jwtToken") ?? ""
        ]
    }
}
