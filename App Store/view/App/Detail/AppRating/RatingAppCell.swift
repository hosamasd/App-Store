//
//  RatingAppCell.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class RatingAppCell: BaseCell {
    
      let titleLabel =  UILabel(string: "review title ", font: .systemFont(ofSize: 18))
     let authorLabel =  UILabel(string: "hosam mohamed ", font: .systemFont(ofSize: 16))
     let starLabel =  UILabel(string: "stars ", font: .systemFont(ofSize: 14))
     let bodyLabel =  UILabel(string: "this is our app for creating some bug \n iin our layout \n sdfnsdf dfds e ", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override func setupViews() {
       backgroundColor = .lightGray
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stacks = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel,UIView(),authorLabel]),
            starLabel,
            bodyLabel
            ], spacing: 12)
        
    
        addSubview(stacks)
        stacks.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
}
