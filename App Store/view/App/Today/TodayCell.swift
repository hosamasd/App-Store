//
//  TodayCell.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayItemCell {
    
    override var todayItem:TodayItem! {
        didSet{
            guard let  item = todayItem else { return  }
            self.categoryLabel.text = item.category
            self.titleLabel.text = item.title
            self.centerImage.image =  item.image
            self.imageContainerView.backgroundColor = item.backgroundColor
            backgroundColor = item.backgroundColor
        }
    }
    
    let categoryLabel = UILabel(string: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(string: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))
    let descriptionLabel = UILabel(string: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    let centerImage:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "garden"))
        im.clipsToBounds = true
        return im
    } ()
    var imageContainerView = UIView()
    var topConstraint:NSLayoutConstraint!
    
    
    override func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 16
        
        imageContainerView = UIView()
        imageContainerView.addSubview(centerImage)
        centerImage.centerInSuperview(size: .init(width: 200, height: 200))
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel, titleLabel, imageContainerView, descriptionLabel
            ], spacing: 8)
        addSubview(stackView)
        
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint.isActive = true
    }
}
