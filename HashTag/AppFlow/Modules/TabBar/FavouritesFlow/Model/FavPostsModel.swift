// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
import Foundation
// MARK: - Welcome
struct FavPostsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: FavPostsData?
}

// MARK: - DataClass
struct FavPostsData: Codable {
    let data: [FavPostsModel?]?
    let links: Links?
    let meta: Meta?
}

// MARK: - Datum
struct FavPostsModel: Codable {
    let id: Int?
    let title, des, videoURL, statusID: String?
    let viewCount: Int?
    let url:String?
    let photo: String?
    let pinned: Bool?
    let createdDate, createAtDayNumber, createAtYearNumber, createdTime: String?
    let timeAmOrPm: String?
    let category: Category?
    let createdDateYear, createdDateMonth, createdDateDay: String?
    var read, bookmark,shareFacebook: Bool?
    let shareTwitter: Bool?
    var like:Bool?
    var likeCount:Int
    var shareCountForFacebook, shareCountForTwitter, commentsCount: Int?
    let comments: [CommentsModel]?
    let tags: [TagModel]?
    let createdAtDay, createdAtMonth: String?

    enum CodingKeys: String, CodingKey {
        case id, title, des,url
        case videoURL = "video_url"
        case statusID = "status_id"
        case viewCount = "view_count"
        case photo, pinned
        case createdDate = "created_date"
        case createAtDayNumber = "create_at_day_number"
        case createAtYearNumber = "create_at_year_number"
        case createdTime = "created_time"
        case timeAmOrPm = "time_am_or_pm"
        case category
        case createdDateYear = "created_date_year"
        case createdDateMonth = "created_date_month"
        case createdDateDay = "created_date_day"
        case read, bookmark, like
        case shareFacebook = "share_facebook"
        case shareTwitter = "share_twitter"
        case likeCount = "like_count"
        case shareCountForFacebook = "share_count_for_facebook"
        case shareCountForTwitter = "share_count_for_twitter"
        case commentsCount = "comments_count"
        case comments, tags
        case createdAtDay = "created_at_day"
        case createdAtMonth = "created_at_month"
    }
}



