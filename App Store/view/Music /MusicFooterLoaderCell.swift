//
//  MusicFooterLoaderCell.swift
//  App Store
//
//  Created by hosam on 5/13/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MusicFooterLoaderCell: UICollectionReusableView {
    
    let activityIndicator:UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        return aiv
    }()
    let label:UILabel = {
        let label = UILabel(string: "Loading more...", font: .systemFont(ofSize: 16))
        label.textAlignment = .center
        return label
    }()
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        let stackView = getStacks(views: activityIndicator,label, axis: .vertical, space: 8)
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
    }
}
