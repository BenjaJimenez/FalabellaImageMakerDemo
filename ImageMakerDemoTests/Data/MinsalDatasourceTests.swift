//
//  MinsalDatasourceTests.swift
//  ImageMakerDemoTests
//
//  Created by Benjamin on 21-10-20.
//

import XCTest
@testable import ImageMakerDemo


class MinsalDatasourceTests: XCTestCase {
    
    var datasource : MinsalDatasource!
    var api: MockAPI!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        api = MockAPI()
        datasource = MinsalDatasource(apiClient: api)
    }

    func testPharmaciesRequest() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        datasource.getPharmacies(completion: {_ in })
        XCTAssertTrue(api.called)
        XCTAssertEqual("https://farmanet.minsal.cl/index.php/ws/getLocales", api.url)
    }
}
