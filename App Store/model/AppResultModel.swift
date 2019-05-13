//
//  AppResultModel.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import Foundation

struct AppResultModel : Codable{
    let resultCount: Int
    let results: [Result]
}

struct Result: Codable {
    let trackId :Int
    let  trackName:String
    let primaryGenreName: String
    var averageUserRating:Float?
    var screenshotUrls:[String]?
    let artworkUrl100:String
     var formattedPrice:String?
     var description:String?
     var releaseNotes:String?
    var artistName:String?
    var collectionName:String? 
    
    
    
}
