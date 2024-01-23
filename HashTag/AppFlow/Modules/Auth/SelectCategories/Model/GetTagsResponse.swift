//
//  getTagsResponse.swift
//  HashTag
//
//  Created by Trend-HuB on 22/08/1444 AH.
//

import Foundation

// MARK: - Welcome
struct getTagsResponse: Codable {
    let status: Bool?
    let message: String?
    let data:[TagsModel]?
}

// MARK: - Datum
struct TagsModel: Codable {
    let id: Int?
    let name: String?
    let count: Int?
}
