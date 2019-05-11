//
//  TodayVC.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class TodayVC: BaseListController {
    
    fileprivate let cellId = "cellId"
    
    let items = [
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white),
        TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        let item = items[indexPath.row]
        
       cell.items = item
        return cell
    }
    
    var appFullVC:AppFullScreenVC!
    
    var topCons:NSLayoutConstraint?
    var leadingCons:NSLayoutConstraint?
    var widthCons:NSLayoutConstraint?
    var heightCons:NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appFullVC = AppFullScreenVC()
         appFullVC.item = self.items[indexPath.row]
        appFullVC.handleCloseClosure = {
           
            self.handleRemoveView()
        }
        let redView = appFullVC.view!
        
        addChild(appFullVC)
        self.appFullVC = appFullVC
        redView.layer.cornerRadius = 16
        
        view.addSubview(redView)
        
         self.collectionView.isUserInteractionEnabled = false
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return  }
        
        //absolute cord of cell
        guard let startFrame = cell.superview?.convert(cell.frame, to: nil) else { return  }
        self.startingFrame = startFrame
        
        redView.translatesAutoresizingMaskIntoConstraints = false
        
         topCons = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: startFrame.origin.y)
          leadingCons = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startFrame.origin.x)
         widthCons = redView.widthAnchor.constraint(equalToConstant: startFrame.width)
         heightCons = redView.heightAnchor.constraint(equalToConstant: startFrame.height)
        
        [topCons, leadingCons, heightCons, widthCons].forEach({$0?.isActive = true})
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
           
            
            
            self.topCons?.constant = 0
            self.leadingCons?.constant = 0
            self.widthCons?.constant = self.view.frame.width
            self.heightCons?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded() // start animation
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: nil)
    }
    var startingFrame: CGRect?
    
  @objc  func handleRemoveView()  {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
        
        self.appFullVC.tableView.contentOffset = .zero
        
        guard let startingFrame = self.startingFrame else{return}
        self.topCons?.constant = startingFrame.origin.y
        self.leadingCons?.constant = startingFrame.origin.x
        self.widthCons?.constant = startingFrame.width
        self.heightCons?.constant = startingFrame.height
        
        self.view.layoutIfNeeded() // start animation
        self.tabBarController?.tabBar.transform = .identity
    }) { (_) in
       
        self.appFullVC.view.removeFromSuperview()
        self.appFullVC.removeFromParent()
        self.collectionView.isUserInteractionEnabled = true
    }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    fileprivate func setupCollectionViews() {
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = .lightGray
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
    }
}
