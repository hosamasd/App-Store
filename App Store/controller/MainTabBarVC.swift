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
        //check if login or not
//        self.delegate = self
      
        
        setupViewControllers()
    }
    
    //MARK: -USER METHODS
    
    fileprivate func setupViewControllers() {
        
        let today = templateNavControllerVC(title: "Today", selectedImage: #imageLiteral(resourceName: "today_icon"), rootViewController: UIViewController())
        let search = templateNavControllerVC(title: "Search", selectedImage: #imageLiteral(resourceName: "search"), rootViewController: AppSearchVC() )
        let apps = templateNavControllerVC(title: "Apps", selectedImage: #imageLiteral(resourceName: "apps"), rootViewController: AppsListVC())
        
        
        tabBar.tintColor = .black
        
        viewControllers = [
             apps,
            search,
            today,
           
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
//extension MainTabBarVC: UITabBarControllerDelegate {
//
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let index = tabBarController.viewControllers?.index(of: viewController)
//        if index == 2 {
//            let photo = PhotoSelectorVC(collectionViewLayout: UICollectionViewFlowLayout())
//            let nav = UINavigationController(rootViewController: photo)
//
//            present(nav, animated: true, completion: nil)
//
//            return false
//        }
//        return true
//
//    }
//}

