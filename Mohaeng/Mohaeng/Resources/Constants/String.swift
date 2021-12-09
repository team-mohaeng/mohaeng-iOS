//
//  String.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/21.
//

import Foundation

extension Const {
    
    struct String {
        
        // 코스 변경 팝업
        static let changeCoursePopUpTitle = "지금 포기하는 거야?"
        static let changeCoursePopUpContent = "기존 코스를 포기하면 새로 시작한 코스 첫날의 해피지수를  받을 수 없어 ㅠㅠ"
        
        // 코스 시작 팝업
        static let startCoursePopUpTitle = "새로운 코스를 시작할 거야?"
        static let startCoursePopUpContent = "코스를 완료하면 해피 지수가 와르르!마지막 챌린지까지 파이팅이닷"
        
        // 회원 탈퇴 팝업
        static let withdrawalPopUpTitle = "회원 탈퇴하기"
        static let withdrawalPopUpContent = "탈퇴하면 그동안 모아왔던 해피지수와 캐릭터 스타일 카드가 모두 사라져!"
        
        // MARK: - Error Strings
        
        static let pathErr = "pathErr 발생. 개발자에게 문의해주세요."
        static let serverErr = "serverErr 발생. 개발자에게 문의해주세요."
        static let networkFail = "네트워크 상태가 좋지 않습니다. 잠시 후 다시 시도해주세요."
    }
    
}
