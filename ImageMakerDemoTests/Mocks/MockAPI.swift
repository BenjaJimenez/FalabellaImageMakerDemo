//
//  MockAPI.swift
//  ImageMakerDemoTests
//
//  Created by Benjamin on 21-10-20.
//

import Foundation
@testable import ImageMakerDemo

class MockAPI: APIClient {
    var called = false
    var url = ""
    func request(url: String, completion: @escaping (Data?) -> Void) {
        called = true
        self.url = url
    }
}
