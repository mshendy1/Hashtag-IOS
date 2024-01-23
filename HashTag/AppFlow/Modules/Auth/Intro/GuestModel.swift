//
//  GuestModel.swift
//  HashTag
//
//  Created by Trend-HuB on 09/11/1444 AH.
//

import Foundation

struct GuestResponse: Codable {
    let status: Bool?
    let message: String?
    let data: GuestModel?
}

// MARK: - Datum
struct GuestModel: Codable {
    let turnNotification: Bool?
    enum CodingKeys: String, CodingKey {
        case turnNotification = "turn_notification"
    }
}

