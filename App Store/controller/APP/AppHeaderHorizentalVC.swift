//
//  AppHeaderHorizentalVC.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppHeaderHorizentalVC: SnappingHorizentalVC  {
    
    fileprivate let cellId = "cellId"
    var socialAppArray = [SocialAModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    //MARK: -UICollectionView methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialAppArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppHeaderHorizentalCell
        let social = socialAppArray[indexPath.item]
        
        cell.companyLabel.text = social.name
        cell.titleLabel.text = social.tagline
        cell.appBigImage.sd_setImage(with: URL(string: social.imageUrl ?? ""))
        //        cell.socials = social
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 48, height: view.frame.height)
    }
    
    //MARK: -user methods
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .yellow
        if  let layout = collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
        collectionView.backgroundColor = .white
        collectionView.register(AppHeaderHorizentalCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
