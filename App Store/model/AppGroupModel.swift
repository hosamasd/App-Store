//
//  AppGroupModel.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

struct AppGroupModel: Codable {
    let feed:Feed
    
}

struct Feed: Codable {
    let title: String
    let id: String
    
    let copyright, country: String
    let icon: String
    let updated: String
   let results: [FeedResult]
}

struct FeedResult: Codable {
    let id, artistName, artworkUrl100, name: String
   
   
}
