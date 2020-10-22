//
//  MockGetPharmacies.swift
//  ImageMakerDemoTests
//
//  Created by Benjamin on 21-10-20.
//

import Foundation
@testable import ImageMakerDemo

class MockGetPharmacies: GetPharmacies {
    
    var called = false
    var pharmacies: [Pharmacy]? = nil
    
    init() {
        super.init(datasource: MockPharmacyDatasource(), searchDatasource: MockSearchDatasource())
    }
    
    override func get(keyword: String? = nil, limit: Int? = nil, completion: @escaping ([Pharmacy]?) -> Void) {
        called = true
        completion(pharmacies)
    }
    
}
