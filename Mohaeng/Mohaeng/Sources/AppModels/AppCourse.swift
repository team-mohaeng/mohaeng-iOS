//
//  AppCourse.swift
//  Journey
//
//  Created by 초이 on 2021/09/08.
//

import UIKit

enum AppCourse: Int {
    // 늘 건강행, 나 케어행, 꼭 지켜야행, 꺅 일탈행, 호 추억행, 쪽 사랑행, 짱 똑똑행
    // 건강, 셀프케어, 습관, 도전, 추억, 사랑, 교양
    
    // rawValue 순서대로
    // 건강행, 케어행, 지켜야행, 일탈행, 추억행, 사랑행, 똑똑행
    
    case health = 1, selfCare, habit, challenge, memory, love, culture
    
    static var count: Int { return AppCourse.culture.rawValue }
    
    func getKorean() -> String {
        
        switch self {
        case .health:
            return "늘 건강행"
        case .selfCare:
            return "나 케어행"
        case .habit:
            return "꼭 지켜야행"
        case .challenge:
            return "꺅 일탈행"
        case .memory:
            return "호 추억행"
        case .love:
            return "쪽 사랑행"
        case .culture:
            return "짱 똑똑행"
        }
        
    }
    
    func getLightColor() -> UIColor {
        switch self {
        case .love:
            return UIColor.RedThemeLight
        case .culture:
            return UIColor.OrangeThemeLight
        case .memory:
            return UIColor.YellowThemeLight
        case .health:
            return UIColor.GreenThemeLight
        case .selfCare:
            return UIColor.BlueThemeLight
        case .habit:
            return UIColor.IndigoThemeLight
        case .challenge:
            return UIColor.PurpleThemeLight
        }
    }
    
    func getDarkColor() -> UIColor {
        switch self {
        case .love:
            return UIColor.RedThemeDark
        case .culture:
            return UIColor.OrangeThemeDark
        case .memory:
            return UIColor.YellowThemeDark
        case .health:
            return UIColor.GreenThemeDark
        case .selfCare:
            return UIColor.BlueThemeDark
        case .habit:
            return UIColor.IndigoThemeDark
        case .challenge:
            return UIColor.PurpleThemeDark
        }
    }
    
    func getBubbleColor() -> UIColor {
        switch self {
        case .love:
            return UIColor.RedThemeBubble
        case .culture:
            return UIColor.OrangeThemeBubble
        case .memory:
            return UIColor.YellowThemeBubble
        case .health:
            return UIColor.GreenThemeBubble
        case .selfCare:
            return UIColor.BlueThemeBubble
        case .habit:
            return UIColor.IndigoThemeBubble
        case .challenge:
            return UIColor.PurpleThemeBubble
        }
    }
    
    func getBigImage() -> UIImage {
        switch self {
        case .love:
            return Const.Image.redBigImage
        case .culture:
            return Const.Image.orangeBigImage
        case .memory:
            return Const.Image.yellowBigImage
        case .health:
            return Const.Image.greenBigImage
        case .selfCare:
            return Const.Image.blueBigImage
        case .habit:
            return Const.Image.indigoBigImage
        case .challenge:
            return Const.Image.purpleBigImage
        }
    }
    
    func getLibraryImage() -> UIImage {
        switch self {
        case .love:
            return Const.Image.redLibraryImage
        case .culture:
            return Const.Image.orangeLibraryImage
        case .memory:
            return Const.Image.yellowLibraryImage
        case .health:
            return Const.Image.greenLibraryImage
        case .selfCare:
            return Const.Image.blueLibraryImage
        case .habit:
            return Const.Image.indigoLibraryImage
        case .challenge:
            return Const.Image.purpleLibraryImage
        }
    }
    
    func getSmallImage() -> UIImage {
        switch self {
        case .love:
            return Const.Image.redSmallImage
        case .culture:
            return Const.Image.orangeSmallImage
        case .memory:
            return Const.Image.yellowSmallImage
        case .health:
            return Const.Image.greenSmallImage
        case .selfCare:
            return Const.Image.blueSmallImage
        case .habit:
            return Const.Image.indigoSmallImage
        case .challenge:
            return Const.Image.purpleSmallImage
        }
    }
    
    func getUndoneStampImage() -> UIImage {
        switch self {
        case .love:
            return Const.Image.redUndoneStampImage
        case .culture:
            return Const.Image.orangeUndoneStampImage
        case .memory:
            return Const.Image.yellowUndoneStampImage
        case .health:
            return Const.Image.greenUndoneStampImage
        case .selfCare:
            return Const.Image.blueUndoneStampImage
        case .habit:
            return Const.Image.indigoUndoneStampImage
        case .challenge:
            return Const.Image.purpleUndoneStampImage
        }
    }
    
    func getDoneStampImage() -> UIImage {
        switch self {
        case .love:
            return Const.Image.redDoneStampImage
        case .culture:
            return Const.Image.orangeDoneStampImage
        case .memory:
            return Const.Image.yellowDoneStampImage
        case .health:
            return Const.Image.greenDoneStampImage
        case .selfCare:
            return Const.Image.blueDoneStampImage
        case .habit:
            return Const.Image.indigoDoneStampImage
        case .challenge:
            return Const.Image.purpleDoneStampImage
        }
    }
    
    func getOnBoardingDescription() -> String {
        
        switch self {
        case .health:
            return "건강한 신체와 정신을 위한 챌린지"
        case .selfCare:
            return "나 스스로를 케어하는 챌린지"
        case .habit:
            return "규칙적인 생활 습관을 위한 챌린지"
        case .challenge:
            return "반복되는 일상을 벗어나게 해줄 도전적인 챌린지"
        case .memory:
            return "추억과 관련된 챌린지"
        case .love:
            return "친구, 가족, 멘토와 관련된 챌린지"
        case .culture:
            return "교양과 관련된 챌린지"
        }
        
    }
    
    func getOnboardingCourse() -> [String] {
        
        switch self {
        case .health:
            return ["햇살 가득한 하루", "햇빛 아래에서 광합성하기"]
        case .selfCare:
            return ["내가 제일 잘 나가", "오늘의 나한테 칭찬해주기"]
        case .habit:
            return ["일찍 일어나는 새", "나를 위한 응원의 한 마디"]
        case .challenge:
            return ["밤에 듣는 즉흥환상곡", "밤에 산책 또는 자전거타기"]
        case .memory:
            return ["중급 사진가", "오늘 입은 옷 찍기"]
        case .love:
            return ["친구찾아 삼만리", "오늘의 tmi 물어보기"]
        case .culture:
            return ["지구촌 촌장되기", "3개 국어 인삿말 말하기"]
        }
        
    }
}
