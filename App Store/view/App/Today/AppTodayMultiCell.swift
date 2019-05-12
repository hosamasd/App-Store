//
//  AppTodayMultiCell.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppTodayMultiCell: BaseCell {
    
    
    var appFeeds:FeedResult? {
        didSet{
            guard let app = appFeeds else { return }
            
            guard  let url = URL(string: app.artworkUrl100) else {return}
            
            self.appImage.sd_setImage(with: url)
            self.appNameLabel.text = app.name
            self.appCompanyLabel.text = app.artistName
        }
    }
    
    let appImage:UIImageView = {
        let im = UIImageView(cornerRdius: 12)
        im.constrainWidth(constant: 64)
        im.constrainHeight(constant: 64)
        im.backgroundColor = .red
        return im
    }()
    
    let appNameLabel:UILabel = {
        let la = UILabel(string: "App Name", font: .systemFont(ofSize: 20))
        return la
    }()
    let appCompanyLabel:UILabel = {
        let la = UILabel(string: "Company Name", font: .systemFont(ofSize: 13))
        
        return la
    }()
    lazy var getButton:UIButton = {
        let bt  = UIButton(title: "GET")
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(white: 0.95, alpha: 1)
        bt.setTitleColor(.blue, for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //        bt.addTarget(self, action: #selector(handleGet), for: .touchUpInside)
        bt.constrainHeight(constant: 32)
        bt.constrainWidth(constant: 80)
        return bt
    }()
    
    override func setupViews() {
        let stackLabel = getStacks(views: appNameLabel,appCompanyLabel, axis: .vertical, space: 4)
        
        let stacks = getStacks(views: appImage,stackLabel,getButton, axis: .horizontal, space: 16)
        stacks.alignment = .center
        addSubview(stacks)
        stacks.fillSuperview()
    }
}
