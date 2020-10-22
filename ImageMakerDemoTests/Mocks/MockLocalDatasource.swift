//
//  MockUserDefaultsDatasource.swift
//  FalabellaImageMakerDemoTests
//
//  Created by Benjamin on 20-10-20.
//

import Foundation
@testable import ImageMakerDemo


class MockUserDefaultsDatasource: UserDatasource {
    var logCalled = false
    var registerCalled = false
    var name: String? = nil
    
    func logUser(username: String, password: String) -> String? {
        logCalled = true
        return name
    }
    
    func register(username: String, name: String, password: String) -> Bool {
        registerCalled = true
        return true
    }
}
