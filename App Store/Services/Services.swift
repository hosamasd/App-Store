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
    
    
    
    
    func fetchFreeApps(completion: @escaping (AppGroupModel?, Error?) ->())  {
        let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"
        fetchAppGroups(urlString: url, completion: completion)
    }
    func fetchTopGrossing(completion: @escaping (AppGroupModel?, Error?) ->())  {
         let urls = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"
        
        fetchAppGroups(urlString: urls, completion: completion)
        
        
    }

    func fetchAppGroups(urlString:String ,completion: @escaping (AppGroupModel?, Error?) ->())  {
         guard  let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if err != nil {
                print(err?.localizedDescription)
                
                completion(nil,err)
            }
            guard let dats = data else {return}
            do{
                let welcome = try JSONDecoder().decode(AppGroupModel.self, from: dats)
                completion(welcome,nil)
            }catch let jsonErr {
                completion(nil,err)
            }
            
            }.resume()
    }
    
    func fetchSocialApps(completion: @escaping ([SocialAModel]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode([SocialAModel].self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
}
