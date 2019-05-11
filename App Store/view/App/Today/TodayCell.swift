//
//  TodayCell.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class TodayCell: BaseCell {
    
    let centerImage:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "garden"))
        im.contentMode = .scaleAspectFill
        
        return im
    } ()
    
    
    override func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addSubview(centerImage)
        centerImage.centerInSuperview(size: .init(width: 200, height: 200))
    }
}
