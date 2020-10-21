//
//  PharmacyDatasource.swift
//  ImageMakerDemo
//
//  Created by Benjamin on 20-10-20.
//

import Foundation
import Alamofire

public protocol PharmacyDatasource {
    func getPharmacies(completion: @escaping ([Pharmacy]?) -> Void)
}

public struct MinsalDatasource : PharmacyDatasource {
    
    public func getPharmacies(completion: @escaping ([Pharmacy]?) -> Void){
        AF.request("https://farmanet.minsal.cl/index.php/ws/getLocales").response { response in
            guard let data = response.data else {
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
