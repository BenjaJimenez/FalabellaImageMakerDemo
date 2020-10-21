//
//  GetPharmaciesTests.swift
//  ImageMakerDemoTests
//
//  Created by Benjamin on 21-10-20.
//

import XCTest
@testable import ImageMakerDemo


class GetPharmaciesTests: XCTestCase {
    
    var uc: GetPharmacies!
    var ds: MockPharmacyDatasource!
    var sds: MockSearchDatasource!

    override func setUp(){
        ds = MockPharmacyDatasource()
        sds = MockSearchDatasource()
        uc = GetPharmacies(datasource: ds, searchDatasource: sds)
    }

    override func tearDownWithError() throws {
        ds.called = false
        sds.called = false
    }

    func testNoSearchFields() throws {
        uc.get{_ in }
        XCTAssertTrue(ds.called)
        XCTAssertFalse(sds.called)
    }
    
    func testInvalidSearchFields() throws {
        uc.get(keyword: "", limit: 0){_ in }
        XCTAssertTrue(ds.called)
        XCTAssertFalse(sds.called)
    }
    
    func testLimitSearchFields() throws {
        uc.get(limit: 10){_ in }
        XCTAssertFalse(ds.called)
        XCTAssertTrue(sds.called)
    }
    
    func testKeySearchFields() throws {
        uc.get(keyword: "key"){_ in }
        XCTAssertFalse(ds.called)
        XCTAssertTrue(sds.called)
    }
    
    func testAllSearchFields() throws {
        uc.get(keyword: "key", limit: 10){_ in }
        XCTAssertFalse(ds.called)
        XCTAssertTrue(sds.called)
    }
}
