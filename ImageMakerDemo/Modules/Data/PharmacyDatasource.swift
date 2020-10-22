//
//  PharmacyDatasource.swift
//  ImageMakerDemo
//
//  Created by Benjamin on 20-10-20.
//

import Foundation


public protocol PharmacyDatasource {
    func getPharmacies(completion: @escaping ([Pharmacy]?) -> Void)
}

public struct MinsalDatasource : PharmacyDatasource {
    
    var apiClient: APIClient
    
    public func getPharmacies(completion: @escaping ([Pharmacy]?) -> Void){
        apiClient.request(url: Constants.url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let result = try JSONDecoder().decode([Pharmacy].self, from: data)
                completion(result)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
}

fileprivate struct Constants {
    static let url = "https://farmanet.minsal.cl/index.php/ws/getLocales"
}
