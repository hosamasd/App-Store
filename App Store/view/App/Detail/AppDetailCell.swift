//
//  AppDetailCell.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    var apps:Result?  {
        didSet{
            appImage.sd_setImage(with: URL(string: apps?.artworkUrl100 ?? ""))
            appNameLabel.text = apps?.trackName
            appPriceButton.setTitle(apps?.formattedPrice, for: .normal)
            releaseNoteLabel.text = apps?.releaseNotes
        }
    }
    
    let appImage:UIImageView = {
        let im = UIImageView(cornerRdius: 16)
        im.backgroundColor = .red
        im.constrainWidth(constant: 140)
        im.constrainHeight(constant: 140)
        return im
    }()
    
    let appNameLabel:UILabel =  UILabel(string: "App Name fhddf fghdf hfg fghfd hf fghdfdfh fdh ", font: .systemFont(ofSize: 24), numberOfLines: 2)
    
    lazy var appPriceButton:UIButton = {
        let bt  = UIButton(title: "$20")
        bt.layer.cornerRadius = 16
        bt.backgroundColor = #colorLiteral(red: 0.2094819546, green: 0.4698699713, blue: 0.9831175208, alpha: 1)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //        bt.addTarget(self, action: #selector(handleGet), for: .touchUpInside)
        bt.constrainHeight(constant: 32)
        bt.constrainWidth(constant: 80)
        return bt
    }()
    let whatNewLabel = UILabel(string: "whats news", font: .systemFont(ofSize: 16))
    let releaseNoteLabel = UILabel(string: "Company Name", font: .systemFont(ofSize: 14), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setupViews() {
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                appImage,
                VerticalStackView(arrangedSubviews: [
                    appNameLabel,
                    UIStackView(arrangedSubviews: [appPriceButton, UIView()]),
                    UIView()
                    ], spacing: 12)
                ], customSpacing: 20),
            whatNewLabel,
            releaseNoteLabel
            ], spacing: 16)
        
        addSubview(stackView)
        
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
}
