//
//  TrendGoogleResponse.swift
//  HashTag
//
//  Created by Eman Gaber on 17/02/2023.
//

import Foundation
// MARK: - Welcome
struct TrendGoogleResponse: Codable {
    let status: Bool
    let message: String
    let data: [TrendGoogleModel?]?
}

// MARK: - Datum
struct TrendGoogleModel: Codable {
    let title, traffic: String?
}
