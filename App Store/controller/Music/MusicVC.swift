//
//  MusicVC.swift
//  App Store
//
//  Created by hosam on 5/13/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MusicVC: BaseListController{
    
    fileprivate let cellId = "cellId"
    fileprivate let cellFooterId = "cellFooterId"
    var isPaginating = false
    var isDonePaginating = false
    var results = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        fetchData()
    }
    
    fileprivate let searchTerm = "taylor"
    
    fileprivate func fetchData() {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
        Services.shared.fetchGenericJSONData(urlString: urlString) { (appResult: AppResultModel?, err) in
            
            if let err = err {
                print("Failed to paginate data:", err)
                return
            }
            self.results = appResult?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MusicTrackCell
        let music = results[indexPath.item]
        
        //check for making pagination!
        if indexPath.item == results.count - 1 && !isPaginating {
            
            isPaginating = true
            
            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
            Services.shared.fetchGenericJSONData(urlString: urlString) { (appResult: AppResultModel?, err) in
                
                if let err = err {
                    print("Failed to paginate data:", err)
                    return
                }
                
                if appResult?.results.count == 0 {
                    self.isDonePaginating = true
                }
                
                sleep(2)
                
                self.results += appResult?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                self.isPaginating = false
            }
        }
        
        cell.musics = music
        return cell
    }
    
    override  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellFooterId, for: indexPath)  as! MusicFooterLoaderCell
        
        return footer
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let height:CGFloat = isDonePaginating ? 0 : 100
        
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
    
    fileprivate func setupCollectionViews() {
        collectionView.backgroundColor = .white
        collectionView.register(MusicTrackCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MusicFooterLoaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: cellFooterId)
    }
    
}
