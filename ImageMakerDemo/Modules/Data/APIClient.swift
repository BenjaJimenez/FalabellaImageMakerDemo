//
//  APIClient.swift
//  ImageMakerDemo
//
//  Created by Benjamin on 21-10-20.
//

import Foundation
import Alamofire

public protocol APIClient {
    func request(url: String, completion: @escaping (Data?) -> Void)
}

struct AlamoAPIClient : APIClient {
    func request(url: String, completion: @escaping (Data?) -> Void){
        AF.request(url).response { response in
            completion(response.data)
        }
    }

}
