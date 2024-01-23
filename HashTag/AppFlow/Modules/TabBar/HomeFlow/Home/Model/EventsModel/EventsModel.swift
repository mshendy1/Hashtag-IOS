//
//  EventsModel.swift
//  HashTag
//
//  Created by Eman Gaber on 18/02/2023.
//

import Foundation

// MARK: - Welcome
struct EventsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: EventsData?
}

// MARK: - DataClass
struct EventsData: Codable {
    let data: [EventModel?]?
    let links: Links?
    let meta: Meta?
}

// MARK: - Datum
struct EventModel: Codable {
    let id: Int?
    let title, description, creator: String?
    let email:String?
    let phone:String?
    let videoURL:VideoURLUnion?
    let location: String?
    let lat, lng: Double?
    let website, facebook, twitter, instagram: String?
    let mainPhoto: String?
    let video: String?
    var createdAt:String
    let createAtDayNumber, createAtYearNumber, createdTime: String?
    let timeAmOrPm: String
    let status: String?
    let start_at: String
    let approvedDate: String?
    let categoryID: [CategoryIdModel?]?
    let events: [Event]?
    let city: String?
    let statusID: Int
    let createdAtDay, createdAtMonth: String?
    var bookmark: Bool
    let all_date:String?

    enum CodingKeys: String, CodingKey {
        case id, title, description, creator, email, phone
        case videoURL = "video_url"
        case location, lat, lng, website, facebook, twitter, instagram
        case mainPhoto = "main_photo"
        case video
        case createdAt = "created_at"
        case createAtDayNumber = "create_at_day_number"
        case createAtYearNumber = "create_at_year_number"
        case createdTime = "created_time"
        case timeAmOrPm = "time_am_or_pm"
        case status
        case start_at
        case all_date 
        case approvedDate = "approved_date"
        case categoryID = "category_id"
        case events, city
        case statusID = "status_id"
        case createdAtDay = "created_at_day"
        case createdAtMonth = "created_at_month"
        case bookmark
    }
}

// MARK: - Event
struct Event: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Links
struct Links: Codable {
    let first, last: String?
    let prev, next: String?
}

// MARK: - Meta
struct Meta: Codable {
    let currentPage, from, lastPage: Int?
    let links: [Link]?
    let path: String?
    let perPage, to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case links, path
        case perPage = "per_page"
        case to, total
    }
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}



enum VideoURLUnion: Codable {
    case string(String)
    case videoURLClass(VideoURLClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(VideoURLClass.self) {
            self = .videoURLClass(x)
            return
        }
        throw DecodingError.typeMismatch(VideoURLUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for VideoURLUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .videoURLClass(let x):
            try container.encode(x)
        }
    }
}

struct VideoURLClass: Codable {
}


struct CategoryIdModel: Codable {
    let id: Int?
    let name, icon: String?
}
