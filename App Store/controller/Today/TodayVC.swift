//
//  TodayVC.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class TodayVC: BaseListController {
    
    static let cellSize: CGFloat = 500
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    var items = [TodayItem]()
    var appFullVC:AppFullScreenVC!
    var anchorConstraints:AnchoredConstraints?
    
    var startingFrame: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        
        setupCollectionViews()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //solve problem of bad tabbar place and put it in correct place
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    
    
    //MARK:-UICollectionView methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = items[indexPath.item]
        
        let cellType = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType, for: indexPath) as! BaseTodayItemCell
        
        cell.todayItem = items[indexPath.item]
        
        (cell as? AppTodayMultipleCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMaultiAppTapped)))
        return cell
    }
    
    //    fileprivate func makeConstraintSetup(top:NSLayoutConstraint,leading:NSLayoutConstraint,width:NSLayoutConstraint,height:NSLayoutConstraint,_ redView: UIView, _ startFrame: CGRect) {
    //        topCons = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: startFrame.origin.y)
    //        leadingCons = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startFrame.origin.x)
    //        widthCons = redView.widthAnchor.constraint(equalToConstant: startFrame.width)
    //        heightCons = redView.heightAnchor.constraint(equalToConstant: startFrame.height)
    //    }
    
    @objc func handleMaultiAppTapped(gesture:UITapGestureRecognizer){
        let collection = gesture.view
        
        var superview = collection?.superview
        
        while superview != nil {
            if let cell = superview as? AppTodayMultipleCell {
                
                guard let index = self.collectionView.indexPath(for: cell) else {return}
                
                showDailyListFullScreen(index)
            }
            superview = superview?.superview
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch items[indexPath.item].cellType {
        case .multi:
            showDailyListFullScreen(indexPath)
        default:
            showSingleAppFullScreen(indexPath: indexPath)
        }
        
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
        collectionView.backgroundColor = #colorLiteral(red: 0.9555082917, green: 0.9493837953, blue: 0.9556146264, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(AppTodayMultipleCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multi.rawValue)
    }
    
    fileprivate func setupActivityIndicator() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
    }
    
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullController = AppTodayMultiVC(mode: .fullScreen)
        fullController.appResult = items[indexPath.item].apps
        present(BackEnabledNavigationController(rootViewController: fullController), animated: true, completion: nil)
    }
    
    func setupSingleAppFullScreen(_ indexPath:IndexPath)  {
        let appFullVC = AppFullScreenVC()
        appFullVC.item = self.items[indexPath.row]
        
        appFullVC.handleCloseClosure = {
            
            self.handleRemoveView()
        }
        appFullVC.view.layer.cornerRadius = 16
        self.appFullVC = appFullVC
    }
    
    func setupAppFullScreenPosition(_ indexPath:IndexPath)  {
        let fullScreenApp = appFullVC.view!
        
        addChild(appFullVC)
        
        view.addSubview(fullScreenApp)
        
        self.collectionView.isUserInteractionEnabled = false
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return  }
        
        //absolute cord of cell
        guard let startFrame = cell.superview?.convert(cell.frame, to: nil) else { return  }
        self.startingFrame = startFrame
        
        self.anchorConstraints = fullScreenApp.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: startFrame.origin.y, left: startFrame.origin.x, bottom: 0, right: 0),size: .init(width: startFrame.width, height: startFrame.height))
        
        self.view.layoutIfNeeded()
    }
    
    
    
    func beginAnimationAppFullScreen()  {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            
            self.anchorConstraints?.top?.constant = 0
            self.anchorConstraints?.leading?.constant = 0
            self.anchorConstraints?.width?.constant = self.view.frame.width
            self.anchorConstraints?.height?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded() // start animation
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            guard let cel = self.appFullVC.tableView.cellForRow(at: [0,0]) as? AppFullScreenHeaderCell else {return}
            cel.mainImageCell.topConstraint.constant = 48
            cel.layoutIfNeeded()
        }, completion: nil)
    }
    
    func showSingleAppFullScreen(indexPath:IndexPath)  {
        //setup VC
        setupSingleAppFullScreen(indexPath)
        //position of vc
        setupAppFullScreenPosition(indexPath)
        //animate it
        beginAnimationAppFullScreen()
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
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, apps: [],cellType: .single),
                TodayItem.init(category: "the daily list", title: grocessingGrroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, apps: grocessingGrroup?.feed.results ?? [],cellType: .multi),
                TodayItem.init(category: "the daily list", title: appsGrroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, apps: appsGrroup?.feed.results ?? [],cellType: .multi),
                TodayItem.init(category: "MULTIPLE CELL", title: "Test-Drive These CarPlay Apps", image: #imageLiteral(resourceName: "holiday"), description: "", backgroundColor: #colorLiteral(red: 0.9925484061, green: 0.9600889087, blue: 0.7310721278, alpha: 1), apps: [], cellType: .single),
                
            ]
            
            self.collectionView.reloadData()
        }
    }
    
    //TODO: -handle methods
    
    @objc  func handleRemoveView()  {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            
            self.appFullVC.tableView.contentOffset = .zero
            
            guard let startingFrame = self.startingFrame else{return}
            self.anchorConstraints?.top?.constant = startingFrame.origin.y
            self.anchorConstraints?.leading?.constant = startingFrame.origin.x
            self.anchorConstraints?.width?.constant = startingFrame.width
            self.anchorConstraints?.height?.constant = startingFrame.height
            
            
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
