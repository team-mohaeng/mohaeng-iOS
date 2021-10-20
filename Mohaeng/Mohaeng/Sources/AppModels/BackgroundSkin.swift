//
//  BackgroundSkin.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/10/18.
//

import UIKit

enum BackgroundSkin: Int {
    
    case yellowBg = 0, spreadBg, cloudBg, fieldBg, nightBg, figureBg
    
    func getOwnedSkinIcn() -> UIImage {
        switch self {
        case .yellowBg:
            return Const.Image.yellowBg
        case .spreadBg:
            return Const.Image.spreadBg
        case .cloudBg:
            return Const.Image.cloudBg
        case .fieldBg:
            return Const.Image.fieldBg
        case .nightBg:
            return Const.Image.nightBg
        case .figureBg:
            return Const.Image.figureBg
        }
    }
    
    func getLockSkinIcn() -> UIImage {
        switch self {
        case .yellowBg:
            return Const.Image.yellowLock
        case .spreadBg:
            return Const.Image.spreadLock
        case .cloudBg:
            return Const.Image.cloudLock
        case .fieldBg:
            return Const.Image.fieldLock
        case .nightBg:
            return Const.Image.nightLock
        case .figureBg:
            return Const.Image.figureLock
        }
    }
    
    func getSelectedSkinIcn() -> UIImage {
        switch self {
        case .yellowBg:
            return Const.Image.yellowSelected
        case .spreadBg:
            return Const.Image.spreadSelected
        case .cloudBg:
            return Const.Image.cloudSelected
        case .fieldBg:
            return Const.Image.fieldSelected
        case .nightBg:
            return Const.Image.nightSelected
        case .figureBg:
            return Const.Image.figureSelected
        }
    }
}
