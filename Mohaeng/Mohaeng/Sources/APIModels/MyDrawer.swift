//
//  MyDrawer.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/15.
//

import Foundation

// MARK: - MyDrawerResponseData
struct MyDrawerResponseData: Codable {
    let status: Int
    let data: MyDrawerData
}

// MARK: - DataClass
struct MyDrawerData: Codable {
    let myDrawerSmallSatisfactions: [Feed]
}
