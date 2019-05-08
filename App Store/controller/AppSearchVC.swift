//
//  AppSearchVC.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppSearchVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    
    fileprivate let cellId = "cellId"
    fileprivate var appResultsArray = [Result]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchAppsFromItubes()
    }
    
    func fetchAppsFromItubes()  {
        Services.shared.fetchApps { (res, err) in
            if err != nil {
                print("error to fetch apps ",err?.localizedDescription)
                return
            }
            
            self.appResultsArray = res
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResultsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        let apps = appResultsArray[indexPath.row]
        
        cell.apps = apps
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    //MARK: - user methods
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
