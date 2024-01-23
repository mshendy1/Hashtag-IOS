//
//  EventDetailsModel.swift
//  HashTag
//
//  Created by Trend-HuB on 24/07/1444 AH.
//
import Foundation

// MARK: - Welcome
struct EventDetailsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: EventDetailsModel?
}

// MARK: - DataClass
struct EventDetailsModel: Codable {
    let id: Int
    let title, description, shortDescription, creator ,url: String?
    let email, phone, videoURL, location: String?
    let lat, lng: Double?
    let website, facebook, twitter, instagram: String?
    let mainPhoto: String?
    let video, createdAt, createAtDayNumber, createAtYearNumber: String?
    let createdAtMonth, createdTime, timeAmOrPm, status: String?
    let startAt, approvedDate: String?
    let categoryID: [CategoryIdModel?]?
    let events: [Event]?
    let city: String?
    let statusID: Int?
    var bookmark: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title, description, shortDescription, creator,url,email, phone
        case videoURL = "video_url"
        case location, lat, lng, website, facebook, twitter, instagram
        case mainPhoto = "main_photo"
        case video
        case createdAt = "created_at"
        case createAtDayNumber = "create_at_day_number"
        case createAtYearNumber = "create_at_year_number"
        case createdAtMonth = "created_at_month"
        case createdTime = "created_time"
        case timeAmOrPm = "time_am_or_pm"
        case status
        case startAt = "start_at"
        case approvedDate = "approved_date"
        case categoryID = "category_id"
        case events, city
        case statusID = "status_id"
        case bookmark = "bookmark"
    }
}

