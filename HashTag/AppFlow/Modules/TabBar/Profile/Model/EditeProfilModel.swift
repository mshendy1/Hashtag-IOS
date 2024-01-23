//
//  EditeProfilModel.swift
//  HashTag
//
//  Created by Trend-HuB on 14/08/1444 AH.
//


import Foundation

// MARK: - Welcome
struct EditeProfilRespons: Codable {
    let status: Bool?
    let message: String?
    let data: EditeProfilData?
}

// MARK: - WelcomeData
struct EditeProfilData: Codable {
    let data: User?
}


