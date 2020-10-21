//
//  HomePresenterTests.swift
//  FalabellaImageMakerDemoTests
//
//  Created by Benjamin on 20-10-20.
//

import XCTest
@testable import ImageMakerDemo

class HomePresenterTests: XCTestCase {
    
    fileprivate var ui: MockUI!
    var uc: MockGetPharmacies!
    var presenter: HomePresenter!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        ui = MockUI()
        uc = MockGetPharmacies()
        presenter = HomePresenter(getPharmacies: uc, mapper: HomeViewMapper(), ui: ui)
    }
    
    override func tearDownWithError() throws {
        uc.pharmacies = nil
        uc.called = false
        
        ui.askedConfirmation = false
        ui.destination = nil
        ui.vms = []
        ui.displayCalled = false
    }
    
    func testLoadEmptyData(){
        presenter.loadData()
        XCTAssertTrue(uc.called)
        XCTAssertNotNil(presenter.pharmacies)
        XCTAssertEqual(presenter.pharmacies.count, 0)
    }
    
    func testLoadData(){
        uc.pharmacies = [Pharmacy(), Pharmacy(), Pharmacy()]
        presenter.loadData()
        XCTAssertTrue(uc.called)
        XCTAssertNotNil(presenter.pharmacies)
        XCTAssertEqual(presenter.pharmacies.count, 3)
    }
    
    func testMapInvalidData(){
        presenter.mapResults([Pharmacy(), Pharmacy()])
        XCTAssertFalse(ui.displayCalled)
        XCTAssertEqual(ui.vms.count, 0)
    }
    
    func testMapMixedData(){
        let validPharmacy: Pharmacy = {
            var p = Pharmacy()
            p.id = "1"
            p.name = "name"
            p.address = "address"
            p.city = "city"
            return p
        }()
        
        let invalidPharmacy: Pharmacy = {
            var p = Pharmacy()
            p.address = "address"
            p.city = "city"
            return p
        }()
        
        presenter.mapResults([Pharmacy(), validPharmacy, invalidPharmacy])
        XCTAssertTrue(ui.displayCalled)
        XCTAssertEqual(ui.vms.count, 1)
    }
    
    func testMapValidData(){
        let validPharmacy: Pharmacy = {
            var p = Pharmacy()
            p.id = "1"
            p.name = "name"
            p.address = "address"
            p.city = "city"
            return p
        }()
        
        let validPharmacy2: Pharmacy = {
            var p = Pharmacy()
            p.id = "2"
            p.name = "name"
            p.address = "address"
            p.city = "city"
            return p
        }()
        
        let validPharmacy3: Pharmacy = {
            var p = Pharmacy()
            p.id = "3"
            p.name = "name"
            p.address = "address"
            p.city = "city"
            return p
        }()
        let pharmacies  = [validPharmacy, validPharmacy2, validPharmacy3]
        presenter.mapResults(pharmacies)
        XCTAssertTrue(ui.displayCalled)
        XCTAssertEqual(ui.vms.count, pharmacies.count)
    }
    
    func testMappingData(){
        let validPharmacy: Pharmacy = {
            var p = Pharmacy()
            p.id = "1"
            p.name = "name"
            p.address = "address"
            p.city = "city"
            return p
        }()
        
        presenter.mapResults([validPharmacy])
        XCTAssertTrue(ui.displayCalled)
        XCTAssertEqual(ui.vms.count, 1)
        
        let vm = ui.vms[0]
        XCTAssertEqual(validPharmacy.id, vm.id)
        XCTAssertEqual(validPharmacy.name, vm.name)
        XCTAssertEqual(validPharmacy.address, vm.address)
        XCTAssertEqual(validPharmacy.city, vm.city)
        
    }

    func testLogoutAsk() throws {
        presenter.logoutSelected()
        XCTAssertTrue(ui.askedConfirmation)
    }
    
    func testLogoutConfirm() throws {
        presenter.logoutConfirmed()
        XCTAssertNotNil(ui.destination)
        XCTAssertEqual(Route.back, ui.destination)
    }

}

fileprivate class MockUI: HomeUI {
    
    var askedConfirmation = false
    var destination: Route!
    var vms: [PharmacyCell] = []
    var displayCalled = false
    
    func displayPharmacies(_ pharmacies: [PharmacyCell]) {
        displayCalled = true
        vms = pharmacies
    }
    
    func askLogoutConfirmation() {
        askedConfirmation = true
    }
    
    func navigate(to route: Route) {
        destination = route
    }
    
    
}
