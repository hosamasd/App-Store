//
//  SearchCell.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import SDWebImage

class SearchCell: BaseCell {
    
    var apps:Result? {
        didSet{
            guard let app = apps else { return  }
        self.appNameLabel.text = app.trackName
            self.appCategLabel.text = app.primaryGenreName
            
          
            self.appImage.sd_setImage(with: URL(string: app.artworkUrl100))
            self.appScreenShot1Image.sd_setImage(with: URL(string: app.screenshotUrls![0]))
          
            if app.screenshotUrls!.count > 1 {
                 self.appScreenShot2Image.sd_setImage(with: URL(string: app.screenshotUrls![1]))
            }
            if app.screenshotUrls!.count > 2 {
                self.appScreenShot3Image.sd_setImage(with: URL(string: app.screenshotUrls![2]))
            }
            
            
            self.ratingsLabel.text = "Rating: \(app.averageUserRating ?? 0)"
        }
    }
    
    let appImage:UIImageView = {
        let im = UIImageView()
        im.layer.cornerRadius = 12
        im.clipsToBounds = true
        im.widthAnchor.constraint(equalToConstant: 64).isActive = true
        im.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return im
    }()
   
    let appNameLabel:UILabel = {
        let la = UILabel()
      
        return la
    }()
    let appCategLabel:UILabel = {
        let la = UILabel()
      
        return la
    }()
    let ratingsLabel:UILabel = {
        let la = UILabel()
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
    
   
   
   
    
    override func setupViews()  {
        
        let stacksLabel = getStacks(views: appNameLabel,appCategLabel,ratingsLabel, axis: .vertical, space: 0)
        let infoAppStack = getStacks(views: appImage,stacksLabel,getButton, axis: .horizontal, space: 12)
        infoAppStack.alignment = .center
        
        let screenShotStacks = getStacks(views: appScreenShot1Image,appScreenShot2Image,appScreenShot3Image, axis: .horizontal, space: 12)
        screenShotStacks.distribution = .fillEqually
        
        let mainStacks = getStacks(views: infoAppStack,screenShotStacks, axis: .vertical, space: 16)
        
        addSubview(mainStacks)
        
        mainStacks.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    func createScreenSots() -> UIImageView {
        let im = UIImageView()
        im.backgroundColor = .blue
        im.layer.cornerRadius = 8
        im.clipsToBounds = true
        im.layer.borderWidth = 0.5
        im.contentMode = .scaleAspectFill
        im.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        return im
    }
    
    @objc func handleGet(){
        print(123)
    }
}
