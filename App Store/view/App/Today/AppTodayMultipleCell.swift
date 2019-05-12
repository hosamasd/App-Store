//
//  AppTodayMultipleCell.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppTodayMultipleCell: BaseTodayItemCell {
    
    override  var todayItem: TodayItem!{
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            multipleAppsController.appResult = todayItem.apps
            multipleAppsController.collectionView.reloadData()
        }
    }
    
    let categoryLabel = UILabel(string: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(string: "Utilizing your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
    
    let multipleAppsController = AppTodayMultiVC(mode: .small)
    override func setupViews() {
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            multipleAppsController.view
            ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
}
