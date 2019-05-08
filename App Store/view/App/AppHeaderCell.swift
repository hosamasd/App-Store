//
//  AppHeaderCell.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppHeaderCell: UICollectionReusableView {
    
     let horizentalCollectionView = AppHeaderHorizentalVC()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView()  {
       
        
        addSubview(horizentalCollectionView.view)
        horizentalCollectionView.view.fillSuperview()
    }
}
