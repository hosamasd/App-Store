//
//  AppSearchVC.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppSearchVC: BaseListController {
    
    let defaultTextLable:UILabel = {
       let la = UILabel()
        la.text = "Please enter search item above"
        la.textAlignment = .center
        la.font = UIFont.boldSystemFont(ofSize: 18)
        
        return la
    }()
    
    
    fileprivate let cellId = "cellId"
    fileprivate var appResultsArray = [Result]()
   fileprivate let searchController = UISearchController(searchResultsController: nil)
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.addSubview(defaultTextLable)
        defaultTextLable.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        setupCollectionView()
        setupSearchController()
//        fetchAppsFromItubes()
    }
    
    
    
     //MARK: -UICollectionView methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        defaultTextLable.isHidden = appResultsArray.count != 0
        return appResultsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        let apps = appResultsArray[indexPath.row]
        
        cell.apps = apps
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let appId = String(self.appResultsArray[indexPath.item].trackId)
        let details = AppDetailVC(appId: appId)
       
        navigationController?.pushViewController(details, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    //MARK: - user methods
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
 fileprivate   func fetchAppsFromItubes()  {
        Services.shared.fetchApps(searchText: "Instagram") { (res, err) in
            if err != nil {
                print("error to fetch apps ",err)
                return
            }
            
            self.appResultsArray = res?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
  fileprivate  func setupSearchController()  {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
}

extension AppSearchVC :UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        if searchText.count == 0 {
            self.appResultsArray.removeAll()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            Services.shared.fetchApps(searchText: searchText) { (res, err) in
                if err != nil {
                    print("error to fetch apps ",err)
                    return
                }
                
                self.appResultsArray = res?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
   }
    
    
}
