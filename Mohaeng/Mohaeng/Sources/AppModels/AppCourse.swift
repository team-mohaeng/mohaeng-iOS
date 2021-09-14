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
        return UIImage()
    }
    
    func getLibraryImage() -> UIImage {
        return UIImage()
    }
    
    func getSmallImage() -> UIImage {
        return UIImage()
    }
    
    func getUndoneStampImage() -> UIImage {
        return UIImage()
    }
    
    func getDoneStampImage() -> UIImage {
        return UIImage()
    }
}
