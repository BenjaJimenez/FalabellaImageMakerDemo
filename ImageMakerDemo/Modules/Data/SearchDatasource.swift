//
//  SearchDatasource.swift
//  ImageMakerDemo
//
//  Created by Benjamin on 21-10-20.
//

import Foundation

public protocol SearchDatasource {
    func search(_ keyword: String?, limit: Int?, completion: @escaping ([Pharmacy]?) -> Void)
}

public struct GobDatasource: SearchDatasource {
    var apiClient: APIClient
    
    public func search(_ keyword: String?, limit: Int?, completion: @escaping ([Pharmacy]?) -> Void) {
    
        var components = URLComponents.init(string: Constants.url)!
        var queryItems = [URLQueryItem(name: Constants.resourceKey, value: Constants.resourceValue)]
        
        
        if let keyword = keyword {
            queryItems.append(URLQueryItem(name: Constants.keyword, value: keyword))
        }
        
        if let limit = limit {
            queryItems.append(URLQueryItem(name: Constants.limit, value: String(limit)))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url?.absoluteString else {
            completion(nil)
            return
        }
        
        apiClient.request(url: url) { (data) in
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let response = try JSONDecoder().decode(SearchReponse.self, from: data)
                completion(response.result?.records)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
}

fileprivate struct Constants {
    static let url = "http://datos.gob.cl/api/action/datastore_search"
    static let resourceKey = "resource_id"
    static let resourceValue = "a60f93af-6a8a-45b6-85ff-267f5dd37ad6"
    static let keyword = "q"
    static let limit = "limit"
}
