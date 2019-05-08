//
//  UIView.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

extension UIView {
    func addsSubvuews(views: UIView...)  {
        views.forEach({addSubview($0)})
    }
    
    func getStacks(views: UIView...,axis: NSLayoutConstraint.Axis,space: CGFloat) -> UIStackView {
        let stacks = UIStackView(arrangedSubviews: views)
        stacks.axis = axis
        stacks.spacing = space
        return stacks
    }
}
