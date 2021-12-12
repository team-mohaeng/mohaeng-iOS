//
//  GenericResponse.swift
//  Journey
//
//  Created by 초이 on 2021/07/15.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    var status: Int
    var message: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
    }
}
