//
//  PollsDetailsModel.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

import Foundation


// MARK: - Welcome
struct PollsDetailsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: PollsDetailsModel?
}

// MARK: - DataClass
struct PollsDetailsModel: Codable {
    let id: Int?
    let media:String?
    let title, des, subDES, type: String?
    let viewCount: Int?
    let createdAt, createdAtDayNumber, createdAtYear, endAt: String?
    let showTotalCount: Int?
    let items: [Item]?
    let category: [Category]?
    let tag: [Item]?
    let images: [String]?
    let video:String?
    let image:String?
    let createdAtDay, createdAtMonth, timeAmOrPm, createdDateYear: String?
    let endAtDay, endAtMonth, endTimeAmOrPm, endDateYear: String?
    var bookmark, read: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title, des
        case subDES = "subDes"
        case type
        case video
        case image
        case viewCount = "view_count"
        case createdAt = "created_at"
        case createdAtDayNumber = "created_at_day_number"
        case createdAtYear = "created_at_year"
        case endAt = "end_at"
        case showTotalCount = "show_total_count"
        case items, category, tag, images
        case createdAtDay = "created_at_day"
        case createdAtMonth = "created_at_month"
        case timeAmOrPm = "time_am_or_pm"
        case createdDateYear = "created_date_year"
        case endAtDay = "end_at_day"
        case endAtMonth = "end_at_month"
        case endTimeAmOrPm = "end_time_am_or_pm"
        case endDateYear = "end_date_year"
        case bookmark, read, media
        
    }
}
