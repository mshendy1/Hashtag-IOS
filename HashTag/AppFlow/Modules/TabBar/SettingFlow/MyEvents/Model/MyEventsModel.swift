//
//  MyEvetsModel.swift
//  HashTag
//
//  Created by Eman Gaber on 27/02/2023.
//

import Foundation

// MARK: - Welcome
struct MyEventsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: MyEvetsData?
}

// MARK: - WelcomeData
struct MyEvetsData: Codable {
    let data: MyEvetsModel?
}

// MARK: - DataData
struct MyEvetsModel: Codable {
    let eventRecent, eventCompleted: MyEvents?
}

// MARK: - Event
struct MyEvents: Codable {
    let data: [Events]?
    let links: Links?
    let meta: Meta?
}

// MARK: - Datum
struct Events: Codable {
    let id: Int?
    let title, description, shortDescription, creator: String?
    let email, phone, videoURL, location: String?
    let lat, lng: Double?
    let website, facebook: String?
    let twitter: String?
    let instagram: String?
    let mainPhoto: String?
    let video, createdAt, createAtDayNumber, createAtYearNumber: String?
    let createdAtMonth, createdTime, timeAmOrPm, status: String?
    let startAt: String
    let approvedDate: String?
    let categoryID: [CategoryIdModel?]?
    let events: [EventElement?]?
    let city: String?
    let statusID: Int?
    let bookmark: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title, description, shortDescription, creator, email, phone
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
        case bookmark
    }
}

// MARK: - EventElement
struct EventElement: Codable {
    let id: Int?
    let name: String?
}
