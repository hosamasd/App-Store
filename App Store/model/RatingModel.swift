//
//  RatingModel.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import Foundation


struct RatingModel: Codable {
    let feed: ReviewFeed
}

struct ReviewFeed: Codable {
    let entry: [Entry]
}

struct Entry: Codable {
    let author: Author
    let title: Label
    let content: Label
    
    let rating: Label
    
    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct Author: Codable {
    let name: Label
}

struct Label: Codable {
    let label: String
}
