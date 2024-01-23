//
//  ResponseUserDetails.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

struct ResponseUserDetails: Codable {
    let status: Bool?
    let message: String?
    let data: WelcomeData?
}

struct WelcomeData: Codable {
    let token: Token?
    let data: UserDetails?
    let message: String?
}

struct UserDetails: Codable {
      let phone: String?
      let dateOfBirth:String?
      let id: Int?
      let createdAt, role: String?
      let genderID: GenderID?
      let email, photo :String
      let name: String?
      let turnNotification: Bool?

      enum CodingKeys: String, CodingKey {
          case phone
          case dateOfBirth = "date_of_birth"
          case id
          case createdAt = "created_at"
          case role
          case genderID = "gender_id"
          case email, photo, name
          case turnNotification = "turn_notification"
      }
}

struct GenderID: Codable {
    let id: Int?
    let name: String?
}

struct Token: Codable {
    let accessToken: String?
    let expireAt: Int?
    let refreshAt: Int?

    enum CodingKeys: String, CodingKey {
        case accessToken
        case expireAt = "expire_at"
        case refreshAt = "refresh_at"
    }
}
