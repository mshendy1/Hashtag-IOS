//
//  SendCodeResponse.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

struct SendCodeResponse: Codable {
    let status: Bool
    let message: String
    let data:DataCode?
}

struct DataCode: Codable {
    let code: Int?
}


struct EmailSendCodeResponse: Codable {
    let status: Bool
    let message: String
    let data:String?
}


