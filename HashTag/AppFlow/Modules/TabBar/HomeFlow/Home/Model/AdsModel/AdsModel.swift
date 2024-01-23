//
//  AdsModel.swift
//  HashTag
//
//  Created by Trend-HuB on 29/07/1444 AH.
//

import Foundation

struct AdsResponse:Codable{
        let status:Bool?
        let message:String?
        let data:[AdsModel?]?
}

struct AdsModel:Codable{
        let id:Int?
        let title :String?
        let image: String?
        let view_count: Int?
        let url:String?
    
}
