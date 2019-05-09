//
//  RatingAppCell.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class RatingAppCell: BaseCell {
    
    var rates:Entry? {
        didSet{
            self.titleLabel.text = rates?.title.label
            self.authorLabel.text = rates?.author.name.label
           
            self.bodyLabel.text = rates?.content.label
            print(rates?.rating.label)
            for(index,view) in starsStackView.arrangedSubviews.enumerated(){
                if let ratingInt = Int(rates?.rating.label ?? "-1") {
                    view.alpha = index >= ratingInt ? 0 : 1
                }
                
            }
        }
    }
    
      let titleLabel =  UILabel(string: "review title ", font: .systemFont(ofSize: 18))
     let authorLabel =  UILabel(string: "hosam mohamed ", font: .systemFont(ofSize: 16))
    
    
    let starsStackView:UIStackView = {
        var arrangedViews = [ UIView]()
        (0..<5).forEach({ (_) in
            let im = UIImageView(image: #imageLiteral(resourceName: "star"))
            im.constrainWidth(constant: 24)
            im.constrainHeight(constant: 24)
            arrangedViews.append(im)
        })
        arrangedViews.append(UIView())
        let stack = UIStackView(arrangedSubviews: arrangedViews)
        return stack
    }()
    
    
     let bodyLabel =  UILabel(string: "this is our app for creating some bug \n iin our layout \n sdfnsdf dfds e ", font: .systemFont(ofSize: 16), numberOfLines: 5)
    
    override func setupViews() {
       backgroundColor = .lightGray
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stacks = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel,authorLabel],customSpacing: 8),
            starsStackView,
            bodyLabel
            ], spacing: 12)
        
        //make it small with large content or collapse
    titleLabel.setContentCompressionResistancePriority(.init(0), for:   .horizontal)
        authorLabel.textAlignment = .right
        
//        //make it bigger when content increase
//        titleLabel.setContentHuggingPriority(.init(0), for: .horizontal)
        
        addSubview(stacks)
        stacks.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
}
