//
//  AppCharacter.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/10/17.
//

import UIKit

enum AppCharacter: Int {
    
    case duck = 0, rabbit, giraffe, elephant, squirrel, bear, hedgehog
    
    func getThumbnailCharacterLockImg() -> UIImage {
        switch self {
        case .duck:
            return Const.Image.duckImg
        case .rabbit:
            return Const.Image.rabbitLockImg
        case .giraffe:
            return Const.Image.giraffeLockImg
        case .elephant:
            return Const.Image.elephantLockImg
        case .hedgehog:
            return Const.Image.hedgehogLockImg
        case .squirrel:
            return Const.Image.squirrelLockImg
        case .bear:
            return Const.Image.bearLockImg
        }
    }
    
    func getThumbnailCharacterImg() -> UIImage {
        switch self {
        case .duck:
            return Const.Image.duckImg
        case .rabbit:
            return Const.Image.rabbitImg
        case .giraffe:
            return Const.Image.giraffeImg
        case .elephant:
            return Const.Image.elephantImg
        case .hedgehog:
            return Const.Image.hedgehogImg
        case .squirrel:
            return Const.Image.squirrelImg
        case .bear:
            return Const.Image.bearImg
        }
    }
    
    func getCardLockImage() -> UIImage {
        switch self {
        case .duck:
            return Const.Image.duckCardLockImg
        case .rabbit:
            return Const.Image.rabbitCardLockImg
        case .giraffe:
            return Const.Image.giraffeCardLockImg
        case .elephant:
            return Const.Image.elephantCardLockImg
        case .hedgehog:
            return Const.Image.hedgehogCardLockImg
        case .squirrel:
            return Const.Image.squirrelCardLockImg
        case .bear:
            return Const.Image.bearCardLockImg
        }
    }
    
}
