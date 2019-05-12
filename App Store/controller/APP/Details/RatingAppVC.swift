//
//  RatingAppVC.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class RatingAppVC: SnappingHorizentalVC {
    
    let cellID = "cellID"
    var rateing:Entry? 
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupCollectionView()
    }
    
     //MARK:-UICollectionView methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! RatingAppCell
       
        cell.rates = rateing
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
     //MARK: -user methods
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(RatingAppCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
