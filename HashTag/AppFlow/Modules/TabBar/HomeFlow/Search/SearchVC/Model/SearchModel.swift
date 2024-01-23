//
//
//  Created by Mohamed Shendy on 31/07/2022.




import Foundation

// MARK: - Welcome
struct SearchOutResponse: Codable {
    let status: Bool?
    let message: String?
    let data: SearchData?
}


struct SearchData: Codable {
    let events:SearchEventData?
    let posts:SearchPostData?
    let surveys:SearchPollsData?
}



struct SearchPollsData: Codable {
    let data: [SearchPollsModel]?
    let links: Links
    let meta: Meta
}

// MARK: - Datum
struct SearchPollsModel: Codable {
    let id: Int?
    let title: String?
    let des: String?
    let subDES, type: String?
    let viewCount: Int?
    let createdAt, createdAtDayNumber, createdAtYear, endAt: String?
    let showTotalCount: Int?
    let items: [Item]?
    let category:[Category]?
    let tag: [TagModel]?
    let allDate: String?
    let image, media: String?
    let read: Bool?
    var bookmark:Bool?

    enum CodingKeys: String, CodingKey {
        case id, title, des
        case subDES = "subDes"
        case type
        case viewCount = "view_count"
        case createdAt = "created_at"
        case createdAtDayNumber = "created_at_day_number"
        case createdAtYear = "created_at_year"
        case endAt = "end_at"
        case showTotalCount = "show_total_count"
        case items, category, tag
        case allDate = "all_date"
        case image, media, bookmark, read
    }
}

// MARK: - Events
struct SearchEventData: Codable {
    let data: [SearchEventsModel]?
    let links: Links?
    let meta: Meta?
}
// MARK: - EventsDatum
struct SearchEventsModel: Codable {
    let id: Int?
    let title, description, shortDescription,url: String?
    let creator: String?
    let email, phone, videoURL, location: String?
    let lat, lng: Double?
    let website, facebook: String?
    let twitter: String?
    let instagram: String?
    let mainPhoto, video: String?
    let createdAt, createAtDayNumber, createAtYearNumber, createdAtMonth: String?
    let createdTime, timeAmOrPm, allDate, status: String?
    let startAt: String?
    let approvedDate: String?
    let categoryID:[Int]?
    let events: [Events]?
    let city: String?
    let statusID: Int?
    var bookmark: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title, description, shortDescription, creator, email, phone
        case videoURL = "video_url"
        case location, lat, lng, website, facebook, twitter, instagram
        case mainPhoto = "main_photo"
        case video,url
        case createdAt = "created_at"
        case createAtDayNumber = "create_at_day_number"
        case createAtYearNumber = "create_at_year_number"
        case createdAtMonth = "created_at_month"
        case createdTime = "created_time"
        case timeAmOrPm = "time_am_or_pm"
        case allDate = "all_date"
        case status
        case startAt = "start_at"
        case approvedDate = "approved_date"
        case categoryID = "category_id"
        case events, city
        case statusID = "status_id"
        case bookmark
    }
}



// MARK: - Posts
struct SearchPostData: Codable {
    let data: [SearchPostModel]?
    let links: Links?
    let meta: Meta?
}

// MARK: - PostsDatum
struct SearchPostModel: Codable {
    let id: Int?
    let title, des, videoURL, statusID: String?
    let viewCount: Int?
    let photo: String?
    let pinned: Bool?
    let createdDate, createAtDayNumber, createAtYearNumber, createdTime , url: String?
    let allDate, timeAmOrPm, createdDateYear, createdDateMonth: String?
    let createdDateDay: String?
    let read, shareFacebook: Bool?
    var bookmark:Bool?
    let shareTwitter: Bool?
    let shareCountForFacebook, shareCountForTwitter, commentsCount: Int?
    var likeCount:Int
    var like:Bool
    let comments: [CommentsModel]?
    let category: Category?
    let tags: [TagModel]?

    enum CodingKeys: String, CodingKey {
        case id, title, des
        case videoURL = "video_url"
        case statusID = "status_id"
        case viewCount = "view_count"
        case photo, pinned,url
        case createdDate = "created_date"
        case createAtDayNumber = "create_at_day_number"
        case createAtYearNumber = "create_at_year_number"
        case createdTime = "created_time"
        case allDate = "all_date"
        case timeAmOrPm = "time_am_or_pm"
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
        case comments, category, tags
    }
}


