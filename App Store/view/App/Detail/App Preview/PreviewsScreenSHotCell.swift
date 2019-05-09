//
//  PreviewsScreenSHotCell.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class PreviewsScreenSHotCell: BaseCell {
    
    let appScreenShotImage = UIImageView(cornerRdius: 12)
    var apps:Result?
        
    
    override func setupViews() {
        addSubview(appScreenShotImage)
        
        appScreenShotImage.fillSuperview()
    }
}
