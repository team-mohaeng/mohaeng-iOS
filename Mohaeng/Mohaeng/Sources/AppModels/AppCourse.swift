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
    
    case health = 0, selfCare, habit, challenge, memory, love, culture
    
    static var count: Int { return AppCourse.culture.rawValue + 1}
    
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
        case .health:
            return UIColor.RedThemeLight
        case .selfCare:
            return UIColor.OrangeThemeLight
        case .habit:
            return UIColor.YellowThemeLight
        case .challenge:
            return UIColor.GreenThemeLight
        case .memory:
            return UIColor.BlueThemeLight
        case .love:
            return UIColor.IndigoThemeLight
        case .culture:
            return UIColor.PurpleThemeLight
        }
    }
    
    func getDarkColor() -> UIColor {
        switch self {
        case .health:
            return UIColor.RedThemeDark
        case .selfCare:
            return UIColor.OrangeThemeDark
        case .habit:
            return UIColor.YellowThemeDark
        case .challenge:
            return UIColor.GreenThemeDark
        case .memory:
            return UIColor.BlueThemeDark
        case .love:
            return UIColor.IndigoThemeDark
        case .culture:
            return UIColor.PurpleThemeDark
        }
    }
    
    func getBubbleColor() -> UIColor {
        switch self {
        case .health:
            return UIColor.RedThemeBubble
        case .selfCare:
            return UIColor.OrangeThemeBubble
        case .habit:
            return UIColor.YellowThemeBubble
        case .challenge:
            return UIColor.GreenThemeBubble
        case .memory:
            return UIColor.BlueThemeBubble
        case .love:
            return UIColor.IndigoThemeBubble
        case .culture:
            return UIColor.PurpleThemeBubble
        }
    }
    
    func getBigImage() -> UIImage {
        switch self {
        case .health:
            return Const.Image.redBigImage
        case .selfCare:
            return Const.Image.orangeBigImage
        case .habit:
            return Const.Image.yellowBigImage
        case .challenge:
            return Const.Image.greenBigImage
        case .memory:
            return Const.Image.blueBigImage
        case .love:
            return Const.Image.indigoBigImage
        case .culture:
            return Const.Image.purpleBigImage
        }
    }
    
    func getLibraryImage() -> UIImage {
        switch self {
        case .health:
            return Const.Image.redLibraryImage
        case .selfCare:
            return Const.Image.orangeLibraryImage
        case .habit:
            return Const.Image.yellowLibraryImage
        case .challenge:
            return Const.Image.greenLibraryImage
        case .memory:
            return Const.Image.blueLibraryImage
        case .love:
            return Const.Image.indigoLibraryImage
        case .culture:
            return Const.Image.purpleLibraryImage
        }
    }
    
    func getSmallImage() -> UIImage {
        switch self {
        case .health:
            return Const.Image.redSmallImage
        case .selfCare:
            return Const.Image.orangeSmallImage
        case .habit:
            return Const.Image.yellowSmallImage
        case .challenge:
            return Const.Image.greenSmallImage
        case .memory:
            return Const.Image.blueSmallImage
        case .love:
            return Const.Image.indigoSmallImage
        case .culture:
            return Const.Image.purpleSmallImage
        }
    }
    
    func getUndoneStampImage() -> UIImage {
        return UIImage()
    }
    
    func getDoneStampImage() -> UIImage {
        return UIImage()
    }
}
