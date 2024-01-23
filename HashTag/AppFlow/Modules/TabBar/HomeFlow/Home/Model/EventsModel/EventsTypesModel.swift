//
//  CategoryTypesModel.swift
//  HashTag
//
//  Created by Trend-HuB on 29/07/1444 AH.
//

import Foundation

struct EventsTypesResponse:Codable{
    let status: Bool?
    let message: String?
    let data: [TypesModel]?
}

    // MARK: - Datum
    struct TypesModel: Codable {
        let id: Int?
        let name: String?
    }

