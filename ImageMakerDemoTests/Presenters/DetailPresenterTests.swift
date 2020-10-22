//
//  DetailPresenterTests.swift
//  ImageMakerDemoTests
//
//  Created by Benjamin on 21-10-20.
//

import XCTest
@testable import ImageMakerDemo


class DetailPresenterTests: XCTestCase {
    
    var presenter: DetailPresenter!
    fileprivate var ui: MockUI!

    override func setUp(){
        ui = MockUI()
        presenter = DetailPresenter(pharmacy: Pharmacy(), mapper: DetailViewMapper(), ui: ui)
    }

    override func tearDownWithError() throws {
        ui.values = []
        ui.called = false
        ui.messageCalled = false
        presenter.pharmacy = Pharmacy()
    }

    func testDisplaySimplePharmacy() throws {
        let pharmacy: Pharmacy = {
            var p = Pharmacy()
            p.id = "1"
            p.city = "city"
            p.address = "address"
            p.name = "name"
            return p
        }()
        presenter.pharmacy = pharmacy
        presenter.displayData()
        XCTAssertEqual(4, ui.values.count)
        XCTAssertFalse(ui.messageCalled)
    }
    
    func testNilPharmacy() throws {
        presenter.displayData()
        XCTAssertFalse(ui.called)
        XCTAssertTrue(ui.messageCalled)
        XCTAssertEqual(0, ui.values.count)
    }
    
    func testMixedPharmacy() throws {
        let pharmacy: Pharmacy = {
            var p = Pharmacy()
            p.id = "1"
            p.city = nil
            p.address = nil
            p.name = "name"
            return p
        }()
        presenter.pharmacy = pharmacy
        presenter.displayData()
        XCTAssertEqual(2, ui.values.count)
        XCTAssertFalse(ui.messageCalled)
    }
    
    func testRequestPharmacy() throws {
        let pharmacy: Pharmacy = {
            var p = Pharmacy()
            p.id = "1"
            p.name = "name"
            p.address = "address"
            p.city = "city"
            p.date = "date"
            p.municipality = "municipality"
            p.openTime = "openTime"
            p.closeTime = "closeTime"
            p.phone = "phone"
            p.latitude = "latitude"
            p.longitude = "longitude"
            p.workingDay = "workingDay"
            p.regionId = "regionId"
            p.municipalityId = "municipalityId"
            p.localityId = "localityId"
            return p
        }()
        presenter.pharmacy = pharmacy
        presenter.displayData()
        XCTAssertEqual(15, ui.values.count)
        XCTAssertFalse(ui.messageCalled)
    }
    
    func testFullPharmacy() throws {
        let pharmacy: Pharmacy = {
            var p = Pharmacy()
            p.id = "1"
            p.name = "name"
            p.address = "address"
            p.city = "city"
            p.date = "date"
            p.municipality = "municipality"
            p.openTime = "openTime"
            p.closeTime = "closeTime"
            p.phone = "phone"
            p.latitude = "latitude"
            p.longitude = "longitude"
            p.workingDay = "workingDay"
            p.regionId = "regionId"
            p.municipalityId = "municipalityId"
            p.localityId = "localityId"
            p.count = "count"
            p.searchId = 2
            p.rank = 0.1
            return p
        }()
        presenter.pharmacy = pharmacy
        presenter.displayData()
        XCTAssertEqual(18, ui.values.count)
        XCTAssertFalse(ui.messageCalled)
    }
}


fileprivate class MockUI : DetailUI {
    
    var values = [String]()
    var called = false
    var messageCalled = false
    func displayList(values: [String]) {
        self.called = true
        self.values = values
    }
    
    func displayError(message: String) {
        messageCalled = true
    }
}
