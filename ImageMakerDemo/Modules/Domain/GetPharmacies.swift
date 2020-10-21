//
//  GetPharmacies.swift
//  ImageMakerDemo
//
//  Created by Benjamin on 20-10-20.
//

import Foundation

public struct GetPharmacies {
    
    var datasource: PharmacyDatasource
    
    func get(completion: @escaping ([Pharmacy]?) -> Void){
        datasource.getPharmacies(completion: completion)
    }
}
