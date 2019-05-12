//
//  BaseCell.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet{
            var transform:CGAffineTransform = .identity
            
            if isHighlighted {
               transform = .init(scaleX: 0.9, y: 0.9)
            }
                     UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = transform
                        })
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.backgroundView?.layer.shadowOpacity = 0.1
        self.backgroundView?.layer.shadowRadius = 10
        self.backgroundView?.layer.shadowOffset = .init(width: 0, height: 10)
        self.backgroundView?.layer.shouldRasterize = true
        
        setupViews()
    }
    
    func setupViews()  {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
