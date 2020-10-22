//
//  UserDefaultsDatasourceTests.swift
//  FalabellaImageMakerDemoTests
//
//  Created by Benjamin on 20-10-20.
//

import XCTest
@testable import ImageMakerDemo

class UserDefaultsDatasourceTests: XCTestCase {
    
    var datasource : UserDefaultsDatasource!
    var ud = MockUserDefaults()

    override func setUpWithError() throws {
        datasource = UserDefaultsDatasource(userDefaults: ud)
    }

    override func tearDownWithError() throws {
        ud.storedKey = nil
        ud.storedData = nil
    }

    func testRegisterUser() throws {
        let someKey = "someKey"
        let result = datasource.register(username: someKey, name: "value", password: "password")
        XCTAssertTrue(result)
        XCTAssertEqual(ud.storedKey, someKey)
    }
    
    func testFailedToRegisterSameUser() throws {
        let someKey = "someKey"
        var result = datasource.register(username: someKey, name: "value", password: "password")
        XCTAssertTrue(result)
        XCTAssertEqual(ud.storedKey, someKey)
        
        XCTAssertNotNil(ud.storedData)
        let data = ud.storedData as! Data
        
        result = datasource.register(username: someKey, name: "value", password: "password")
        XCTAssertFalse(result)
        XCTAssertEqual(ud.storedKey, someKey)
        
        XCTAssertNotNil(ud.storedData)
        let newData = ud.storedData as! Data
        XCTAssertEqual(newData, data)
    }
    
    func testLogUser() throws {
        let someKey = "someKey"
        let somePass = "somePass"
        let someValue = "someValue"
        
        let result = datasource.register(username: someKey, name: someValue, password: somePass)
        XCTAssertTrue(result)
        XCTAssertEqual(ud.storedKey, someKey)
        
        let name = datasource.logUser(username: someKey, password: somePass)
        XCTAssertEqual(name, someValue)
    }
    
    func testFailedToLogUser() throws {
        let someKey = "someKey"
        let somePass = "somePass"
        let someValue = "someValue"
        
        let result = datasource.register(username: someKey, name: someValue, password: somePass)
        XCTAssertTrue(result)
        XCTAssertEqual(ud.storedKey, someKey)
        
        let name = datasource.logUser(username: someKey, password: "anotherPass")
        XCTAssertNil(name)
    }
    
    func testEncryption() throws {
        let someKey = "someKey"
        let somePass = "somePass"
        let someValue = "someValue"
        
        let result = datasource.encrypt(storeKey: someKey, value: someValue, password: somePass)
        XCTAssertNotNil(result)
    }
    
    func testDecryption() throws {
        let someKey = "someKey"
        let somePass = "somePass"
        let someValue = "someValue"
        
        let result = datasource.encrypt(storeKey: someKey, value: someValue, password: somePass)
        XCTAssertNotNil(result)
        
        let decrypt = datasource.decrypt(data: result!, password: somePass)
        XCTAssertNotNil(decrypt)
        XCTAssertEqual(decrypt, someValue)
    }
}
