//
//  CommentsModel.swift
//  HashTag
//
//  Created by Trend-HuB on 02/08/1444 AH.
//

import Foundation

// MARK: - Welcome
struct CommentsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: CommentsDataModel?
}

// MARK: - DataClass
struct CommentsDataModel: Codable {
    let comment: CommentsModel?
}
