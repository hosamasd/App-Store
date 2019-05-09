//
//  AppPreviewCell.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppPreviewCell: BaseCell {
    
    let titleLabel =  UILabel(string: "Preview", font: .boldSystemFont(ofSize: 30))
      
    let reviewHorizentalCollectionView = PreviewScreenShotVC()
    override func setupViews() {
     
        addSubview(titleLabel)
        addSubview(reviewHorizentalCollectionView.view)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 16, bottom: 16, right: 0))
        
        reviewHorizentalCollectionView.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
