//
//  AppDetailVC.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit
import SDWebImage

//depenedency injection constructor when this cell used in different way to present
class AppDetailVC: BaseListController {
    
    let cellID = "cellID"
    let cellPrevID = "cellPrevID"
    let cellRating = "cellRating"
    
    var appResult:Result?
    var ratings:RatingModel?
    
    //dependency
    fileprivate let appId:String
    
    init(appId:String) {
        self.appId = appId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchData()
    }
    
    //MARK:-UICollectionView methods
    
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
            cellPre.reviewHorizentalCollectionView.appsArray = self.appResult
            cellPre.reviewHorizentalCollectionView.collectionView.reloadData()
            return cellPre
        }
        else {
            let cellRate = collectionView.dequeueReusableCell(withReuseIdentifier: cellRating, for: indexPath) as! AppRatingCell
            cellRate.ratingHorizentalCollectionView.rateing = self.ratings?.feed.entry[indexPath.item]
            cellRate.ratingHorizentalCollectionView.collectionView.reloadData()
            return cellRate
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
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
    
    //MARK: -user methods
    
    func fetchData()  {
        let url = "https://itunes.apple.com/lookup?id=\(appId)"
        Services.shared.fetchGenericJSONData(urlString: url) { (res:AppResultModel? , err) in
            if err != nil {
                print("error        ",err)
            }
            self.appResult =  res?.results.first
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
        Services.shared.fetchGenericJSONData(urlString: reviewsUrl) { (rate:RatingModel?, err) in
            self.ratings = rate
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
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
