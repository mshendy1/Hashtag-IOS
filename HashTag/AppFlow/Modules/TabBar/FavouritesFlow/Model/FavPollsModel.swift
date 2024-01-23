
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct FavPollsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: FavPollsData?
}

// MARK: - DataClass
struct FavPollsData: Codable {
    let data: [PollModel]?
    let links: Links?
    let meta: Meta?
}
