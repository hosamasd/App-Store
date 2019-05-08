//
//  Services.swift
//  App Store
//
//  Created by hosam on 5/8/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import Foundation

class Services {
   
    static let shared = Services()
    
    func fetchApps(searchText:String,completion: @escaping ([Result], Error?) ->())  {
         let mainUrl = "https://itunes.apple.com/search?term=\(searchText)&entity=software"
        guard  let url = URL(string: mainUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if err != nil {
                print(err?.localizedDescription)
                completion([],err)
                return
            }
            guard let datas  = data else {return}
            do{
                let appModel = try JSONDecoder().decode(AppResultModel.self, from: datas)
                completion(appModel.results,nil)
           }catch let errs {
            completion([], err)
                print("can not to decode " ,errs.localizedDescription)
            }
            }.resume()
    }
}
