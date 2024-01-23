//
//  GetCategoryResponse.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

struct GetCategoryResponse: Codable {
    let status: Bool
    let message: String
    let data: [CategoryModel]?
}

// MARK: - Datum
struct CategoryModel: Codable {
    let id: Int?
    let name: String?
    let icon: String?
}
