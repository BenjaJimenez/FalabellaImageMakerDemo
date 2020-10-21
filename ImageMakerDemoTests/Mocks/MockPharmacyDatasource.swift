//
//  MockPharmacyDatasource.swift
//  ImageMakerDemoTests
//
//  Created by Benjamin on 20-10-20.
//

import Foundation
@testable import ImageMakerDemo


class MockPharmacyDatasource: PharmacyDatasource {
    
    var pharmacies: [Pharmacy]?
    var called = false
    
    func getPharmacies(completion: @escaping ([Pharmacy]?) -> Void) {
        called = true
        completion(pharmacies)
    }
}
