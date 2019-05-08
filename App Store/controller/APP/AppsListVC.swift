//
//  AppsListVC.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppsListVC: BaseListController {
    
    fileprivate let cellId = "cellId"
     fileprivate let headerId = "headerId"
    var groups = [AppGroupModel]()
    var groupsSocial = [SocialAModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  fetchData()
    }
    
    func fetchData()  {
       
        var group1: AppGroupModel?
        var group2: AppGroupModel?
        var group3: AppGroupModel?
        var group4:[SocialAModel]?
        
        //to sync data that can be fetched
        let dispatchGroup = DispatchGroup()
        
       
          dispatchGroup.enter()
        Services.shared.fetchFreeApps { (apps, err) in
           print("fetch free app")
                 dispatchGroup.leave()
            
           group2 = apps
        }
        
        dispatchGroup.enter()
        Services.shared.fetchAppGroups(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/25/explicit.json") { (apps, err) in
            print("fetch games")
            dispatchGroup.leave()
            
            group3 = apps
        }
        
        dispatchGroup.enter()
        Services.shared.fetchTopGrossing { (apps, err) in
            
            print("fetch grossing")
            dispatchGroup.leave()
            group1 = apps
        }
        
        dispatchGroup.enter()
        Services.shared.fetchSocialApps { (social, err) in
            print("fetch social")
            dispatchGroup.leave()
            group4 = social
        }
        
        dispatchGroup.notify(queue: .main) {
            print("finish work")
            
            if let group = group3 {
                self.groups.append(group)
            }
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
           
            if let group = group4 {
                self.groupsSocial = group
            }
            
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppGroupCell
        let group = self.groups[indexPath.item]
        
        cell.titleLabel.text = group.feed.title
        cell.horizentalCollectionView.appGroups = group
        cell.horizentalCollectionView.collectionView.reloadData()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppHeaderCell
         
        header.horizentalCollectionView.socialAppArray = groupsSocial
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(AppGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
}
