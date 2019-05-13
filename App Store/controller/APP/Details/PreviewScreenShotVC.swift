//
//  AppHeaderPreviewCell.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class PreviewScreenShotVC: SnappingHorizentalVC {
    
    let cellID = "cellID"
    var appsArray:Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupCollectionView()
    }
    
     //MARK:-UICollectionView methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appsArray?.screenshotUrls?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PreviewsScreenSHotCell
        let screen = appsArray?.screenshotUrls?[indexPath.item]
        
        cell.appScreenShotImage.sd_setImage(with: URL(string: screen ?? ""))
        return cell
    }
    
     //MARK: -user methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
    
    fileprivate func setupCollectionView() {
      
         collectionView.backgroundColor = .white
        collectionView.register(PreviewsScreenSHotCell.self, forCellWithReuseIdentifier: cellID)
       
                collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
