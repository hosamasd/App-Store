//
//  TodayItem.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    let apps:[FeedResult] 
    
    let cellType:CellType
    
    enum CellType:String {
        case single, multi
      
    }
    
}
