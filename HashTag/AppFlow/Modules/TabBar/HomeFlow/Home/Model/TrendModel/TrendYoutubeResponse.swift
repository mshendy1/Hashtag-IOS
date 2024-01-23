//
//  TrendYoutube.swift
//  HashTag
//
//  Created by Eman Gaber on 17/02/2023.
//

import Foundation

// MARK: - Welcome
struct TrendYoutubeResponse: Codable {
    let status: Bool?
    let message: String?
    let data: [TrendYoutubeModel?]?
}

// MARK: - Datum
struct TrendYoutubeModel: Codable {
    let url: String?
    let channelTitle: String?
    let channelImg: String?
    let image: String?
    let statistics: StatisticsModel?
    let title, description, publishedAt, createdDate: String?
    let createAtDayNumber, createAtYearNumber, createdTime, timeAmOrPm: String?
    let createdDateYear, createdDateMonth, createdDateDay, player: String?
    let tags: [String]?

    enum CodingKeys: String, CodingKey {
        case url, channelTitle, channelImg, image, statistics, title, description, publishedAt
        case createdDate = "created_date"
        case createAtDayNumber = "create_at_day_number"
        case createAtYearNumber = "create_at_year_number"
        case createdTime = "created_time"
        case timeAmOrPm = "time_am_or_pm"
        case createdDateYear = "created_date_year"
        case createdDateMonth = "created_date_month"
        case createdDateDay = "created_date_day"
        case player, tags
    }
}

// MARK: - Statistics
struct StatisticsModel: Codable {
    let viewCount, likeCount, favoriteCount: String?
    let commentCount: CommentCount?
}
enum CommentCount: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(CommentCount.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CommentCount"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
