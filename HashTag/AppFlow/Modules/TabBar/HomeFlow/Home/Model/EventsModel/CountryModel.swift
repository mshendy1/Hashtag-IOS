//
//  CountryModel.swift
//  HashTag
//
//  Created by Eman Gaber on 18/02/2023.
//

import Foundation


struct CountryResponse: Codable {
    let status: Bool?
    let message: String?
    let data: CountryData?
}

// MARK: - DataClass
struct CountryData: Codable {
    let data: [CountriesModel?]?
}

// MARK: - Datum
struct CountriesModel: Codable {
    let id: Int?
    let name: String?
}
