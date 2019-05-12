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
    
    
    let activityIndicator:UIActivityIndicatorView = {
        let ac  = UIActivityIndicatorView(style: .whiteLarge)
        ac.color = .black
        ac.startAnimating()
        return ac
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //  fetchData()
    }
    
    
    
    //MARK:-UICollectionView methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppGroupCell
        let group = self.groups[indexPath.item]
        
        cell.titleLabel.text = group.feed.title
        cell.horizentalCollectionView.appGroups = group
        cell.horizentalCollectionView.collectionView.reloadData()
        cell.horizentalCollectionView.handleIndexSelected = { [weak self] res in
            let newVC = AppDetailVC(appId: res.id)
            newVC.navigationItem.title = res.name
            print(res.id)
            self?.navigationController?.pushViewController(newVC, animated: true)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppHeaderCell
        
        header.horizentalCollectionView.socialAppArray = groupsSocial
        header.horizentalCollectionView.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    //MARK: -user methods
    
    func fetchData()  {
        
        var group1: AppGroupModel?
        var group2: AppGroupModel?
        var group3: AppGroupModel?
        //to sync data that can be fetched
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Services.shared.fetchFreeApps { (apps, err) in
            dispatchGroup.leave()
            group2 = apps
        }
        
        dispatchGroup.enter()
        
        Services.shared.fetchAppGroups { (apps, err) in
            dispatchGroup.leave()
            group3 = apps
        }
        
        dispatchGroup.enter()
        Services.shared.fetchTopGrossing { (apps, err) in
            dispatchGroup.leave()
            group1 = apps
        }
        
        dispatchGroup.enter()
        Services.shared.fetchSocialApps { (social, err) in
            dispatchGroup.leave()
            self.groupsSocial = social ?? []
        }
        
        dispatchGroup.notify(queue: .main) {
            
            self.activityIndicator.stopAnimating()
            
            if let group = group3 {
                self.groups.append(group)
            }
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setupCollectionView() {
        
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
}
