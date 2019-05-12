//
//  AppListHorizentalVC.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppListHorizentalVC: SnappingHorizentalVC  {
    
    fileprivate let cellId = "cellId"
    var appGroups:AppGroupModel? 
    
    let topBottomPadding:CGFloat = 12
    let linrSpacing:CGFloat = 10
    
    var handleIndexSelected:((FeedResult) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    //MARK: -UICollectionView methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroups?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = self.appGroups?.feed.results[indexPath.item] {
            handleIndexSelected?(index)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        let appFeed = appGroups?.feed.results[indexPath.item]
        
        cell.appFeeds = appFeed
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 48
        let height = (view.frame.height - 2 * topBottomPadding - 2 * linrSpacing) / 3 // 3 for 3 item 20 for valueof minimumLineSpacingForSectionAt
        
        return .init(width: width, height: height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return linrSpacing
    }
    
    //MARK: -user methods
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
}
