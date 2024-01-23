//
//  TrendNewsResponse.swift
//  HashTag
//
//  Created by Eman Gaber on 17/02/2023.
//

import Foundation

// MARK: - Welcome
struct TrendGoogleNewsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: [TrendGoogleNewsModel]?
}



// MARK: - GoogleNew
struct TrendGoogleNewsModel: Codable {
    let title, source, description: String?
    let url: String?
    let image: String?
    let publishedAt, createdDate, createAtDayNumber, createAtYearNumber: String?
    let createdTime: String?
    let timeAmOrPm: String?
    let createdDateYear: String?
    let createdDateMonth: String?
    let createdDateDay: String?

    enum CodingKeys: String, CodingKey {
        case title, source, description, url, image, publishedAt
        case createdDate = "created_date"
        case createAtDayNumber = "create_at_day_number"
        case createAtYearNumber = "create_at_year_number"
        case createdTime = "created_time"
        case timeAmOrPm = "time_am_or_pm"
        case createdDateYear = "created_date_year"
        case createdDateMonth = "created_date_month"
        case createdDateDay = "created_date_day"
    }
}

