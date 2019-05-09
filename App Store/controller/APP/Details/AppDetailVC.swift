//
//  AppDetailVC.swift
//  App Store
//
//  Created by hosam on 5/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppDetailVC: BaseListController {
    
    var appID:String! {didSet{
         let url = "https://itunes.apple.com/lookup?id=\(appID ?? "")"
        Services.shared.fetchGenericJSONData(urlString: url) { (res:AppResultModel? , err) in
            print(res?.results.first?.releaseNotes)
        }
        }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
    }
}
