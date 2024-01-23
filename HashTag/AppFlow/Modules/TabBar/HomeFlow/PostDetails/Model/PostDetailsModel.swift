//
//  PostDetailsModel.swift
//  HashTag
//
//  Created by Trend-HuB on 01/08/1444 AH.
//

import Foundation


struct PostDetailsResponse:Codable{
    let status: Bool?
    let message: String?
    let data: PostDetailsData?
}

// MARK: - DataClass
struct PostDetailsData: Codable {
    let twitterEmbedded,facebookEmbedded:String?
    let id: Int?
    let video:String?
    let title, des, videoURL, statusID: String?
    let viewCount: Int?
    let photo: String?
    let pinned: Bool?
    let createdDate, createAtDayNumber, createAtYearNumber, createdTime: String?
    let timeAmOrPm: String?
    let category: Category?
    let createdDateYear, createdDateMonth, createdDateDay: String?
    var read, bookmark, like, shareFacebook: Bool
    let shareTwitter: Bool?
    var likeCount, shareCountForFacebook, shareCountForTwitter, commentsCount: Int
    let comments: [CommentsModel]?
    let tags: [TagModel]?
    let createdAtDay, createdAtMonth: String?
    let desNoHtml:String?
    let url:String?
    let gallery:[String]?
    let allDate:String?
    

    enum CodingKeys: String, CodingKey {
        case allDate = "allDate"
        case gallery = "gallery"
        case facebookEmbedded = "facebook_embedded"
        case twitterEmbedded = "twitter_embedded"
        case id = "id"
        case title = "title"
        case des = "des"
        case videoURL = "video_url"
        case statusID = "status_id"
        case viewCount = "view_count"
        case photo = "photo"
        case pinned = "pinned"
        case url,video
        case desNoHtml = "des_no_html"
        case createdDate = "created_date"
        case createAtDayNumber = "create_at_day_number"
        case createAtYearNumber = "create_at_year_number"
        case createdTime = "created_time"
        case timeAmOrPm = "time_am_or_pm"
        case category = "category"
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
        case comments = "comments"
        case tags = "tags"
        case createdAtDay = "created_at_day"
        case createdAtMonth = "created_at_month"
    }
}


struct CommentsModel: Codable {
    let id: Int?
    let comment, createAtDate, createAtDayNumber, createAtYearNumber: String?
    let createdAtMonth: String?
    let createdTime: String?
    let timeAmOrPm: String?
    let user: UserModel?
    let mainComment: Int?
    let replay: [ReplayModel]?

    enum CodingKeys: String, CodingKey {
        case id, comment
        case createAtDate = "create_at_date"
        case createAtDayNumber = "create_at_day_number"
        case createAtYearNumber = "create_at_year_number"
        case createdAtMonth = "created_at_month"
        case createdTime = "created_time"
        case timeAmOrPm = "time_am_or_pm"
        case user
        case mainComment = "main_comment"
        case replay
    }
}



