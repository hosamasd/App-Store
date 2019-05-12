//
//  BackEnabledNavigationController.swift
//  App Store
//
//  Created by hosam on 5/12/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class BackEnabledNavigationController: UINavigationController,UIGestureRecognizerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
