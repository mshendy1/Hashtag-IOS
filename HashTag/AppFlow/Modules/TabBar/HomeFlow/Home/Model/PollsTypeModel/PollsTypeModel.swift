//
//  PollsTypeModel.swift
//  HashTag
//
//  Created by Trend-HuB on 19/08/1444 AH.
//

import Foundation


// MARK: - Welcome
struct PollsDetailsTypeResponse: Codable {
    let status: Bool?
    let message: String?
    let data: PollsTypeData?
}

// MARK: - DataClass
struct PollsTypeData: Codable {
    let data: [PollsTypeModel]?
    let links: Links?
    let meta: Meta?
}

// MARK: - Datum
struct PollsTypeModel: Codable {
    let id: Int?
    let title, des, subDES: String?
    let type: TypeEnum
    let viewCount: Int?
    let createdAt, createdAtDayNumber, createdAtYear, endAt: String?
    let showTotalCount: Int?
    let items: [ItemModel]?
    let category: [CategoryModel]?
    let tag: [Item]
    let video: String?
    let createdAtDay: String?
    let createdAtMonth: String?
    let timeAmOrPm: String?
    let createdDateYear, endAtDay: String?
    let endAtMonth: String?
    let endTimeAmOrPm: String?
    let endDateYear: String?
    let bookmark, read: Bool?
    let image: String?
    let media: String?
    let images: [String]?

    enum CodingKeys: String, CodingKey {
        case id, title, des
        case subDES = "subDes"
        case type
        case viewCount = "view_count"
        case createdAt = "created_at"
        case createdAtDayNumber = "created_at_day_number"
        case createdAtYear = "created_at_year"
        case endAt = "end_at"
        case showTotalCount = "show_total_count"
        case items, category, tag, video
        case createdAtDay = "created_at_day"
        case createdAtMonth = "created_at_month"
        case timeAmOrPm = "time_am_or_pm"
        case createdDateYear = "created_date_year"
        case endAtDay = "end_at_day"
        case endAtMonth = "end_at_month"
        case endTimeAmOrPm = "end_time_am_or_pm"
        case endDateYear = "end_date_year"
        case bookmark, read, image, media, images
    }
}



// MARK: - Item
struct ItemModel: Codable {
    let id: Int?
    let name: String
    let count: Int
    let choose: Bool?
}

enum ShowTotalCountModel: Codable {
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
        throw DecodingError.typeMismatch(ShowTotalCount.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ShowTotalCount"))
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

enum TypeEnum: String, Codable {
    case fourImage = "four_image"
    case singleImage = "single_image"
    case video = "video"
}
