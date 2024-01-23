//
//  TrendTwitterResponse.swift
//  HashTag
//
//  Created by Eman Gaber on 17/02/2023.
//

import Foundation

struct TrendTwitterResponse: Codable {
    let status: Bool?
    let message: String?
    let data: [TrendTwitterModel?]?
}

// MARK: - Datum
struct TrendTwitterModel: Codable {
    let name: String?
    let tweetVolume: String?
    let query: String?

    enum CodingKeys: String, CodingKey {
        case name
        case tweetVolume = "tweet_volume"
        case query
    }
}
