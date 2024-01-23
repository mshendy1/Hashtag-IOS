//
//  TermsModel.swift
//  HashTag
//
//  Created by Trend-HuB on 16/08/1444 AH.
//

import Foundation

struct TermsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: TermsModel?
}

// MARK: - DataClass
struct TermsModel: Codable {
    let terms: Terms?
}

// MARK: - Terms
struct Terms: Codable {
    let title, description: String
    let mainPhoto: String?

    enum CodingKeys: String, CodingKey {
        case title, description
        case mainPhoto = "main_photo"
    }
}






// MARK: - Welcome
struct PrivacyResponse: Codable {
    let status: Bool?
    let message: String?
    let data: PrivacyData?
}

// MARK: - DataClass
struct PrivacyData: Codable {
    let privacy: Terms?

    enum CodingKeys: String, CodingKey {
        case privacy = "Privacy"
    }
}

