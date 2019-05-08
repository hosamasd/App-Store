//
//  SearchCell.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    var apps:Result? {
        didSet{
            guard let app = apps else { return  }
        self.appNameLabel.text = app.trackName
            self.appCategLabel.text = app.primaryGenreName
            
            self.appSizeLabel.text = "Rating: \(app.averageUserRating ?? 0)"
        }
    }
    
    let appImage:UIImageView = {
        let im = UIImageView()
        im.layer.cornerRadius = 12
        im.clipsToBounds = true
        im.backgroundColor = .red
        im.widthAnchor.constraint(equalToConstant: 64).isActive = true
        im.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return im
    }()
   
    let appNameLabel:UILabel = {
        let la = UILabel()
        la.text = "app name"
        la.font = UIFont.systemFont(ofSize: 16)
        
        return la
    }()
    let appCategLabel:UILabel = {
        let la = UILabel()
        la.text = "Photos"
        la.font = UIFont.systemFont(ofSize: 16)
        
        return la
    }()
    let appSizeLabel:UILabel = {
        let la = UILabel()
        la.text = "5.5 M"
        la.font = UIFont.systemFont(ofSize: 16)
        return la
    }()
    lazy var getButton:UIButton = {
        let bt  = UIButton()
        bt.setTitle("Get", for: .normal)
        bt.layer.cornerRadius = 16
        bt.backgroundColor = UIColor(white: 0.95, alpha: 1)
        bt.setTitleColor(.blue, for: .normal)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        bt.addTarget(self, action: #selector(handleGet), for: .touchUpInside)
        bt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return bt
    }()
    lazy var appScreenShot1Image = createScreenSots()
    lazy var appScreenShot2Image = createScreenSots()
    lazy var appScreenShot3Image = createScreenSots()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
      setupViews()
    }
    
    func createScreenSots() -> UIImageView {
        let im = UIImageView()
        im.backgroundColor = .blue
        
        return im
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()  {
        
        let stacksLabel = getStacks(views: appNameLabel,appCategLabel,appSizeLabel, axis: .vertical, space: 10)
        let infoAppStack = getStacks(views: appImage,stacksLabel,getButton, axis: .horizontal, space: 12)
        infoAppStack.alignment = .center
        
        let screenShotStacks = getStacks(views: appScreenShot1Image,appScreenShot2Image,appScreenShot3Image, axis: .horizontal, space: 12)
        screenShotStacks.distribution = .fillEqually
        
        let mainStacks = getStacks(views: infoAppStack,screenShotStacks, axis: .vertical, space: 16)
        
        addSubview(mainStacks)
        
        mainStacks.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    @objc func handleGet(){
        print(123)
    }
}
