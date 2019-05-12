//
//  TodayVC.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class TodayVC: BaseListController {
    
   
//    let items = [
    
//        TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1),cellType: .single),
//        TodayItem.init(category: "the daily list", title: "test drive these things car play apps", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white,cellType: .multi),
//    ]
    
    var items = [TodayItem]()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
     var appFullVC:AppFullScreenVC!
    var topCons:NSLayoutConstraint?
    var leadingCons:NSLayoutConstraint?
    var widthCons:NSLayoutConstraint?
    var heightCons:NSLayoutConstraint?
    var startingFrame: CGRect?
    static let cellSize: CGFloat = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        
        setupCollectionViews()
        fetchData()
    }
    
    func fetchData()  {
        let dispatchGroup = DispatchGroup()
        var grocessingGrroup:AppGroupModel?
        var appsGrroup:AppGroupModel?
        
        dispatchGroup.enter()
        Services.shared.fetchTopGrossing { (appGroup, err) in
            grocessingGrroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Services.shared.fetchFreeApps { (appGroup, err) in
            appsGrroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("finished")
            self.activityIndicatorView.stopAnimating()
            self.items = [
                TodayItem.init(category: "the daily list", title: grocessingGrroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, apps: grocessingGrroup?.feed.results ?? [],cellType: .multi),
                TodayItem.init(category: "the daily list", title: appsGrroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, apps: appsGrroup?.feed.results ?? [],cellType: .multi),
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, apps: [],cellType: .single),
            ]
            
            self.collectionView.reloadData()
        }
    }
    
    //MARK:-UICollectionView METHODS
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellType = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType, for: indexPath) as! BaseTodayItemCell
       
        cell.todayItem = items[indexPath.item]
       
        return cell
    }
    
//    fileprivate func makeConstraintSetup(top:NSLayoutConstraint,leading:NSLayoutConstraint,width:NSLayoutConstraint,height:NSLayoutConstraint,_ redView: UIView, _ startFrame: CGRect) {
//        topCons = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: startFrame.origin.y)
//        leadingCons = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startFrame.origin.x)
//        widthCons = redView.widthAnchor.constraint(equalToConstant: startFrame.width)
//        heightCons = redView.heightAnchor.constraint(equalToConstant: startFrame.height)
//    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if items[indexPath.item].cellType == .multi {
            let fullController = AppTodayMultiVC()
            fullController.appResult = items[indexPath.item].apps
            present(fullController, animated: true, completion: nil)
            return
        }
        
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
            
            guard let cel = self.appFullVC.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else {return}
            cel.mainImageCell.topConstraint.constant = 48
            cel.layoutIfNeeded()
        }, completion: nil)
    }
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayVC.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    //ARK: -user methods
    
    fileprivate func setupCollectionViews() {
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = .lightGray
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
       collectionView.register(AppTodayMultipleCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multi.rawValue)
    }
    
    //TODO: -handle methods
    
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
            
            guard let cel = self.appFullVC.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else {return}
            cel.mainImageCell.topConstraint.constant = 24
            cel.layoutIfNeeded()
        }) { (_) in
            
            self.appFullVC.view.removeFromSuperview()
            self.appFullVC.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
            
            
        }
    }
}
