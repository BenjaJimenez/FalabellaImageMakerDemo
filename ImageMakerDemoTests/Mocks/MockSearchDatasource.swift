//
//  MockSearchDatasource.swift
//  ImageMakerDemoTests
//
//  Created by Benjamin on 21-10-20.
//

import Foundation
@testable import ImageMakerDemo

class MockSearchDatasource: SearchDatasource {
    
    var pharmacies: [Pharmacy]?
    var called = false
    
    func search(_ keyword: String?, limit: Int?, completion: @escaping ([Pharmacy]?) -> Void) {
        called = true
        completion(pharmacies)
    }
}
