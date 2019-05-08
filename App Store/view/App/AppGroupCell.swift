//
//  AppGroupCell.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppGroupCell: BaseCell {
    
    let titleLabel:UILabel = {
        let la = UILabel(string: "App Section List", font: .boldSystemFont(ofSize: 30))
        
        return la
    }()
    let horizentalCollectionView = AppListHorizentalVC()
    
    override func setupViews() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(horizentalCollectionView.view)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        
        horizentalCollectionView.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
       
    }
}
