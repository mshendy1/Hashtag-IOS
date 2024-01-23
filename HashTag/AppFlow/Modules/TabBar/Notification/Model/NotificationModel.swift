//
//  NotificationModel.swift
//  HashTag
//
//  Created by Eman Gaber on 27/02/2023.
//

import Foundation

struct SwitchNotificationResponse:Codable{
    let status:Bool?
    let message:String?
    let data:String?
}



// MARK: - Welcome
struct NotificationResponse: Codable {
    let status: Bool?
    let message: String?
    let data: NotificationModel?
}

// MARK: - DataClass
struct NotificationModel: Codable {
    let data: [Notifications]?
    let links: NotificationsLinks?
    let meta: NotificationsMeta?
}

// MARK: - Datum
struct Notifications: Codable {
    let id: Int?
    let title: String?
    let des: String?
    let type: String?
    let itemID: Int?
    let image: String?
    let date:String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, des, type,image,date
        case itemID = "item_id"
    }
}


// MARK: - Links
struct NotificationsLinks: Codable {
    let first, last: String?
    let prev: String?
    let next: String?
}

// MARK: - Meta
struct NotificationsMeta: Codable {
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

