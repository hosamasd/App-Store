//
//  AppDetailVC.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import SDWebImage
class AppDetailVC: BaseListController {
    
    let cellID = "cellID"
     let cellPrevID = "cellPrevID"
    let cellRating = "cellRating"
    
    var appResult:Result?
    
    var appID:String! {didSet{
         let url = "https://itunes.apple.com/lookup?id=\(appID ?? "")"
        Services.shared.fetchGenericJSONData(urlString: url) { (res:AppResultModel? , err) in
            self.appResult =  res?.results.first
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppDetailCell
            cell.apps = appResult
            return cell
        }else if indexPath.item == 1 {
            let cellPre = collectionView.dequeueReusableCell(withReuseIdentifier: cellPrevID, for: indexPath) as! AppPreviewCell
            cellPre.horizentalCollectionView.appsArray = self.appResult
            cellPre.horizentalCollectionView.collectionView.reloadData()
            return cellPre
        }
        else {
            let cellRate = collectionView.dequeueReusableCell(withReuseIdentifier: cellRating, for: indexPath) as! AppRatingCell
            
            return cellRate
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280
        
        if indexPath.item == 0 {
            // calculate the necessary size for our cell somehow
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.apps = appResult
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            height = estimatedSize.height
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 280
        }
        
        return .init(width: view.frame.width, height: height)
     
        
    }
    
    fileprivate func setupCollectionView() {
      navigationItem.largeTitleDisplayMode = .never
      
        collectionView.backgroundColor = .white
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellID)
          collectionView.register(AppPreviewCell.self, forCellWithReuseIdentifier: cellPrevID)
         collectionView.register(AppRatingCell.self, forCellWithReuseIdentifier: cellRating)
//        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
