//
//  AppTodayMultiVC.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppTodayMultiVC: BaseListController {
    
    fileprivate let cellId = "cellId"
    var appResult = [FeedResult]()
     fileprivate let spacing: CGFloat = 16
    lazy var closeButton:UIButton = {
        let bt = UIButton()
        bt.setImage(#imageLiteral(resourceName: "close_button").withRenderingMode(.alwaysOriginal), for: .normal)
        bt.addTarget(self, action: #selector(handleDimiss), for: .touchUpInside)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        setupCloseButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  min(4, appResult.count)
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppTodayMultiCell
        let app = appResult[indexPath.item]

        cell.appFeeds = app
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let height: CGFloat = (view.frame.height - 3 * spacing) / 4
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
   
    fileprivate func fetchData() {
        Services.shared.fetchFreeApps { (app, err) in
            
            self.appResult = app?.feed.results ??  []
          
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    func setupCloseButton()  {
        view.addSubview(closeButton)
        
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 16, left: 0, bottom: 0, right: 8),size: .init(width: 44, height: 44))
    }
    
    fileprivate func setupCollectionViews() {
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false

        collectionView.register(AppTodayMultiCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    @objc func handleDimiss()  {
        dismiss(animated: true)
    }
}
