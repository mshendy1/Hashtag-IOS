//
//  ProfilModel.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//

import Foundation
// MARK: - Welcome
struct ProfilResponse: Codable {
    let status: Bool?
    let message: String?
    let data: ProfilData?
}

// MARK: - DataClass
struct ProfilData: Codable {
    let user: User?
    let userCategory:[Category]?
    let userTags: [TagModel]?

    enum CodingKeys: String, CodingKey {
        case user
        case userCategory = "user_category"
        case userTags = "user_tags"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name, photo, phone, email: String?
    let turnNotification: Bool?
    let dateOfBirth, createdAt, role: String?
    let genderID: GenderID?

    enum CodingKeys: String, CodingKey {
        case id, name, photo, phone, email
        case turnNotification = "turn_notification"
        case dateOfBirth = "date_of_birth"
        case createdAt = "created_at"
        case role
        case genderID = "gender_id"
    }
}


