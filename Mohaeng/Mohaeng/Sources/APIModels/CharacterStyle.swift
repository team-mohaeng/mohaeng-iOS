//
//  CurrentCharacter.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/10/17.
//

import Foundation

// MARK: - CharacterStyleRequest

struct CharacterStyleReqeust {
    var characterSkin: Int
    var characterType: Int
    var characterCard: Int
}

// MARK: - CurrentCharacter

struct CharacterStyle: Codable {
    let currentCharacter, currentSkin: Current
    var characters: [Character]
    let skins: [Skin]
}

// MARK: - Character

struct Character: Codable {
    let type: Int
    var cards: [Card]
}

// MARK: - Card

struct Card: Codable {
    let id: Int
    let image: String
    let hasCard: Bool
    var isNew: Bool
}

// MARK: - Current

struct Current: Codable {
    let id: Int
    let image: String
}

// MARK: - Skin

struct Skin: Codable {
    let id: Int
    let image: String
    let hasSkin: Bool
}
