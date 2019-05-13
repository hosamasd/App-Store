//
//  AppFullScreenHeaderCell.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {
    
    let mainImageCell = TodayCell()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()  {
        addSubview(mainImageCell)
//        addSubview(closeButton)
        
        mainImageCell.fillSuperview()
//        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 44, left: 0, bottom: 0, right: 8),size: .init(width: 80, height: 40))
    }
    
    @objc func handleDimiss()  {
        //    handleCloseClosure(self.superview, <#()#>)
    }
}
