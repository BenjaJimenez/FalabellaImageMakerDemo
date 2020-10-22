//
//  GobDatasourceTests.swift
//  ImageMakerDemoTests
//
//  Created by Benjamin on 21-10-20.
//

import XCTest
@testable import ImageMakerDemo


class GobDatasourceTests: XCTestCase {
    
    var datasource : GobDatasource!
    var api: MockAPI!

    override func setUpWithError() throws {
        api = MockAPI()
        datasource = GobDatasource(apiClient: api)
    }

    func testNoFieldsRequest() throws {

        datasource.search(nil, limit: nil, completion: {_ in })
        XCTAssertTrue(api.called)
        XCTAssertEqual("http://datos.gob.cl/api/action/datastore_search?resource_id=a60f93af-6a8a-45b6-85ff-267f5dd37ad6", api.url)
    }
    
    func testKeyFieldRequest() throws {

        let key = "key"
        datasource.search(key, limit: nil, completion: {_ in })
        XCTAssertTrue(api.called)
        XCTAssertEqual("http://datos.gob.cl/api/action/datastore_search?resource_id=a60f93af-6a8a-45b6-85ff-267f5dd37ad6&q=" + key, api.url)
    }
    
    func testLimitFieldRequest() throws {

        let limit = 10
        datasource.search(nil, limit: 10, completion: {_ in })
        XCTAssertTrue(api.called)
        XCTAssertEqual("http://datos.gob.cl/api/action/datastore_search?resource_id=a60f93af-6a8a-45b6-85ff-267f5dd37ad6&limit=" + String(limit), api.url)
    }
    
    func testAllFieldsRequest() throws {
        
        let key = "key"
        let limit = 10
        datasource.search(key, limit: 10, completion: {_ in })
        XCTAssertTrue(api.called)
        XCTAssertEqual("http://datos.gob.cl/api/action/datastore_search?resource_id=a60f93af-6a8a-45b6-85ff-267f5dd37ad6&q=" + key + "&limit=" + String(limit), api.url)
    }
    
    func testPercentEncodingRequest() throws {
        
        let key = "key#@!_+%?"
        let limit = 10
        datasource.search(key, limit: 10, completion: {_ in })
        XCTAssertTrue(api.called)
        XCTAssertEqual("http://datos.gob.cl/api/action/datastore_search?resource_id=a60f93af-6a8a-45b6-85ff-267f5dd37ad6&q=key%23@!_+%25?&limit=" + String(limit), api.url)
    }

}
