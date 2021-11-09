//
//  Ments.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/11/05.
//

import Foundation

struct Ments {
    var mentList: [HomeMent] {
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            return [
                HomeMent(time: .morning, ment: """
                    \(nickname), 오늘은 모행?
                    오늘두 파이팅이다앗~
                    """),
                HomeMent(time: .morning, ment: """
                    \(nickname), 오늘은 모행?
                    챌린지하구 재밌는 하루 보내!
                    """),
                HomeMent(time: .morning, ment: """
                    \(nickname), 오늘은 모행?
                    보고싶었다구, 기다리고 있었어~
                    """),
                HomeMent(time: .morning, ment: """
                    \(nickname), 오늘은 모행?
                    행복한 하루 보내야행~
                    """),
                HomeMent(time: .afternoon, ment: """
                    \(nickname), 오늘은 모하구있엉?
                    점심 먹었어? 끼니 거르면 안돼!
                    """),
                HomeMent(time: .afternoon, ment: """
                    \(nickname), 오늘은 모하구있엉?
                    아직 자는거 아니지?
                    """),
                HomeMent(time: .afternoon, ment: """
                    \(nickname), 오늘은 모하구있엉?
                    점심은 맛있게 먹었엉?
                    """),
                HomeMent(time: .afternoon, ment: """
                    \(nickname), 오늘은 모하구있엉?
                    챌린지는 다 했어?
                    """),
                HomeMent(time: .night, ment: """
                    \(nickname), 오늘은 모했옹?
                    오늘도 진짜 고생했어
                    """),
                HomeMent(time: .night, ment: """
                    \(nickname), 오늘은 모했옹?
                    깨끗하게 씻고 하루 마무리하자~
                    """),
                HomeMent(time: .night, ment: """
                    \(nickname), 오늘은 모했옹?
                    오늘도 진짜 고생했어
                    """),
                HomeMent(time: .night, ment: """
                    \(nickname), 오늘은 모했옹?
                    행복하게 마무리하길 바랄겡
                    """)

            ]
        }
        return [HomeMent]()
    }
}
