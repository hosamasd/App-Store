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
    
    func fetchApps(searchText:String,completion: @escaping (AppResultModel?, Error?) ->())  {
        let mainUrl = "https://itunes.apple.com/search?term=\(searchText)&entity=software"
        fetchGenericJSONData(urlString: mainUrl, completion: completion)
        
    }
    
    func fetchFreeApps(completion: @escaping (AppGroupModel?, Error?) ->())  {
        let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"
        fetchGenericJSONData(urlString: url, completion: completion)
    }
    func fetchTopGrossing(completion: @escaping (AppGroupModel?, Error?) ->())  {
        let urls = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"
        
        fetchGenericJSONData(urlString: urls, completion: completion)
    }
    
    func fetchAppGroups(completion: @escaping (AppGroupModel?, Error?) ->())  {
        let urlString =  "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/25/explicit.json"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping ([SocialAModel]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJSONData<T: Codable>(urlString:String, completion: @escaping (T?, Error?) -> ())  {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
}
