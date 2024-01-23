//
//  CommonQuesModel.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.
//

import Foundation



struct CommonQuesResponse: Codable {
    let status: Bool?
    let message: String?
    let data: CommonQuesData?
}

// MARK: - DataClass
struct CommonQuesData: Codable {
    let data: [QuesModel]?
    let links: Links?
    let meta: Meta?
}

// MARK: - Datum
struct QuesModel: Codable {
    let id: Int?
    let question, answer: String?
}
