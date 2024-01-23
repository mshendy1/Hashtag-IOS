//
//  ContactUsModel.swift
//  HashTag
//
//  Created by Trend-HuB on 15/08/1444 AH.

import Foundation

// MARK: - Welcome
struct ContactUsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: ContactUsData?
}

// MARK: - ContactUsData
struct ContactUsData: Codable{
    let phone, location, website: String?
    let defaultImg: String?
    let social: SocialModel?
    let siteName, email, copyright, logo: String?

    enum CodingKeys: String, CodingKey {
        case phone, location, website, defaultImg, social
        case siteName = "site_name"
        case email, copyright, logo
    }
}

// MARK: - Social
struct SocialModel: Codable {
    let snapchat, tiktok, twitter, linkedin: Social?
    let appStore, facebook, instagram, googlePlay: Social?
}

// MARK: - AppStore
struct Social: Codable {
    let link: String?
    let image: String?
}

