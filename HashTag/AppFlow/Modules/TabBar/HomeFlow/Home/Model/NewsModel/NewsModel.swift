// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct NewsPostsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: NewsPostsData?
}

// MARK: - DataClass
struct NewsPostsData: Codable {
    let data: [NewsPostsModel?]?
    let links: Links?
    let meta: Meta?
}

// MARK: - Datum
struct NewsPostsModel: Codable {
    let id: Int?
    let title, des: String?
    let desc:String?
    let videoURL: String?
    let video:String?
    let statusID: String?
    let viewCount: Int?
    let photo: String?
    let pinned: Bool
    let url:String?
    let createdDate, createAtDayNumber, createAtYearNumber, createdTime: String?
    let timeAmOrPm: String?
    let category: CategoryModel?
    let createdDateYear, createdDateMonth, createdDateDay: String?
    var like: Bool
    var bookmark: Bool?
    let read, shareFacebook: Bool?
    let shareTwitter: Bool?
    var likeCount,commentsCount:Int
    let shareCountForFacebook, shareCountForTwitter: Int?
    let comments: [CommentModel?]?
    let tags: [TagModel?]?
    let createdAtDay, createdAtMonth: String?
    let allDate:String?
    enum CodingKeys: String, CodingKey {
        case id,title, des,url,video
        case desc = "des_no_html"
        case videoURL = "video_url"
        case statusID = "status_id"
        case viewCount = "view_count"
        case photo = "photo"
        case pinned = "pinned"
        case createdDate = "created_date"
        case createAtDayNumber = "create_at_day_number"
        case createAtYearNumber = "create_at_year_number"
        case createdTime = "created_time"
        case timeAmOrPm = "time_am_or_pm"
        case category
        case createdDateYear = "created_date_year"
        case createdDateMonth = "created_date_month"
        case createdDateDay = "created_date_day"
        case read = "read"
        case bookmark = "bookmark"
        case like = "like"
        case shareFacebook = "share_facebook"
        case shareTwitter = "share_twitter"
        case likeCount = "like_count"
        case shareCountForFacebook = "share_count_for_facebook"
        case shareCountForTwitter = "share_count_for_twitter"
        case commentsCount = "comments_count"
        case comments, tags
        case createdAtDay = "created_at_day"
        case createdAtMonth = "created_at_month"
        case allDate = "all_date"
    }
}


// MARK: - Comment
struct CommentModel: Codable {
    let id: Int?
    let comment, createAtDate: String?
    let user: UserModel?
    let mainComment: Int?
    let replay: [ReplayModel?]?

    enum CodingKeys: String, CodingKey {
        case id, comment
        case createAtDate = "create_at_date"
        case user
        case mainComment = "main_comment"
        case replay
    }
}


// MARK: - Replay
struct ReplayModel: Codable {
    let id: Int?
    let comment, createAtDate: String?
    let user: UserModel?

    enum CodingKeys: String, CodingKey {
        case id, comment
        case createAtDate = "create_at_date"
        case user
    }
}

// MARK: - User
struct UserModel: Codable {
    let id: Int?
    let name: String?
    let photo: String?
    let phone: String?
    let email: String?
    let turnNotification: Bool?
    let dateOfBirth: String?
    let createdAt: String?
    let role: String?
    let genderID: TagModel?

    enum CodingKeys: String, CodingKey {
        case id, name, photo, phone, email
        case turnNotification = "turn_notification"
        case dateOfBirth = "date_of_birth"
        case createdAt = "created_at"
        case role
        case genderID = "gender_id"
    }
}

// MARK: - Tag
struct TagModel: Codable {
    let id: Int?
    let name: String?
}



// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
