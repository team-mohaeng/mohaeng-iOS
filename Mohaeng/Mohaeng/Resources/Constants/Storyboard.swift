//
//  Storyboard.swift
//  Journey
//
//  Created by 초이 on 2021/06/28.
//

import Foundation

extension Const {
    
    struct Storyboard {
        
        struct Name {
            static let tabbar = "Tabbar"
            
            // Auth 관련
            static let login = "Login"
            static let emailLogin = "EmailLogin"
            static let signUpFirst = "SignUpFirst"
            static let signUpSecond = "SignUpSecond"
            static let signUpThird = "SignUpThird"
            static let findPassword = "FindPassword"
            static let code = "Code"
            static let newPassword = "NewPassword"
          
            // 홈 탭
            static let home = "Home"
            static let medal = "Medal"
            static let setting = "Setting"
            static let notification = "Notification"
            static let characterStyle = "CharacterStyle"
            static let myPage = "MyPage"
            static let courseHistory = "CourseHistory"
            
            // 챌린지 탭
            static let course = "Course"
            static let courseLibrary = "CourseLibrary"
            
            // 피드 탭
            static let feed = "Feed"
            static let myDrawer = "MyDrawer"
            static let feedDetail = "FeedDetail"
            static let writing = "Writing"
            static let mood = "Mood"
            static let sticker = "Sticker"
        }
    }
}
