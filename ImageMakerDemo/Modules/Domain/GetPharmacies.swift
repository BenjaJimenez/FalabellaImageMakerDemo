//
//  GetPharmacies.swift
//  ImageMakerDemo
//
//  Created by Benjamin on 20-10-20.
//

import Foundation

public class GetPharmacies {
    
    var datasource: PharmacyDatasource
    var searchDatasource: SearchDatasource
    
    init(datasource: PharmacyDatasource, searchDatasource: SearchDatasource) {
        self.datasource = datasource
        self.searchDatasource = searchDatasource
    }
    
    func get(keyword: String? = nil, limit: Int? = nil, completion: @escaping ([Pharmacy]?) -> Void){
        if !(keyword ?? "").isEmpty || (limit ?? 0) > 0 {
            searchDatasource.search(keyword, limit: limit, completion: completion)
        }else{
            datasource.getPharmacies(completion: completion)
        }
    }
}
