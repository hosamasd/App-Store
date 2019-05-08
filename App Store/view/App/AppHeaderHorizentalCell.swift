//
//  AppHeaderHorizentalCell.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppHeaderHorizentalCell: BaseCell {
    
    let appBigImage:UIImageView = {
        let im = UIImageView(cornerRdius: 8)
       im.backgroundColor = .yellow
       
        return im
    }()
    
    let companyLabel:UILabel = {
        let la = UILabel(string: "Facebook", font: .boldSystemFont(ofSize: 12))
        la.textColor = .blue
        return la
    }()
    let titleLabel:UILabel = {
        let la = UILabel(string: "keeping up with friend is faster than ever! welcome ", font: .systemFont(ofSize: 20))
        la.numberOfLines = 2
        return la
    }()
    override func setupViews() {
        backgroundColor = .white
        
        let stacks = getStacks(views: companyLabel,titleLabel,appBigImage, axis: .vertical, space: 12)
        
        addSubview(stacks)
        stacks.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
}
