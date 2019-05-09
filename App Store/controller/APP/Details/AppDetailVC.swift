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
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppDetailCell
       cell.apps = appResult
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 10000))
        
        dummyCell.apps = appResult
        dummyCell.layoutIfNeeded()
        let estimatedHeight = dummyCell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 10000))
        
        return CGSize(width: view.frame.width, height: estimatedHeight.height)
    }
    
    fileprivate func setupCollectionView() {
      navigationItem.largeTitleDisplayMode = .never
      
        collectionView.backgroundColor = .white
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: cellID)
//        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
