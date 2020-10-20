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
    var presenter: HomePresenter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        ui = MockUI()
        presenter = HomePresenter(ui: ui)
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
    
    func askLogoutConfirmation() {
        askedConfirmation = true
    }
    
    func navigate(to route: Route) {
        destination = route
    }
    
    
}
