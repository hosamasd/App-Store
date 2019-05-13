//
//  MainTabBarVC.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
     //MARK: -user methods
    
    fileprivate func setupViewControllers() {
         let music = templateNavControllerVC(title: "Music", selectedImage: #imageLiteral(resourceName: "music"), rootViewController: MusicVC())
        let today = templateNavControllerVC(title: "Today", selectedImage: #imageLiteral(resourceName: "today_icon"), rootViewController: TodayVC())
        let search = templateNavControllerVC(title: "Search", selectedImage: #imageLiteral(resourceName: "search"), rootViewController: AppSearchVC() )
        let apps = templateNavControllerVC(title: "Apps", selectedImage: #imageLiteral(resourceName: "apps"), rootViewController: AppsListVC())
        
        
        tabBar.tintColor = .black
        
        viewControllers = [
            today,
            apps,
            search,
             music
        ]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavControllerVC(title: String, selectedImage: UIImage, rootViewController: UIViewController )  -> UIViewController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = selectedImage
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        return navController
    }
}

