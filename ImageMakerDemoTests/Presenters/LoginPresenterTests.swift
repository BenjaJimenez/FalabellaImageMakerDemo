//
//  LoginPresenterTests.swift
//  FalabellaImageMakerDemoTests
//
//  Created by Benjamin on 20-10-20.
//

import XCTest
@testable import ImageMakerDemo

class LoginPresenterTests: XCTestCase {
    
    var presenter: LoginPresenter!
    var ds: MockUserDefaultsDatasource!
    fileprivate var ui: MockUI!
    
    override func setUpWithError() throws {
        ui = MockUI()
        ds = MockUserDefaultsDatasource()
        let useCase = LogUser(datasource: ds)
        presenter = LoginPresenter(logUser: useCase, ui: ui)
    }
    
    override func tearDownWithError() throws {
        ds.name = nil
        ui.failedCalled = false
    }
    
    func testLoginInvalidFields() throws {
        
        presenter.logUser(username: nil, password: nil)
        XCTAssertFalse(ds.logCalled)
        XCTAssertTrue(ui.failedCalled)
        ui.failedCalled = false
        
        presenter.logUser(username: "", password: "")
        XCTAssertFalse(ds.logCalled)
        XCTAssertTrue(ui.failedCalled)
        ui.failedCalled = false
        
        presenter.logUser(username: nil, password: "pass")
        XCTAssertFalse(ds.logCalled)
        XCTAssertTrue(ui.failedCalled)
        ui.failedCalled = false
        
        presenter.logUser(username: "user", password: nil)
        XCTAssertFalse(ds.logCalled)
        XCTAssertTrue(ui.failedCalled)
    }

    func testLoginValidFields() throws {
        ds.name = "someName"
        presenter.logUser(username: "user", password: "pass")
        XCTAssertTrue(ds.logCalled)
        XCTAssertFalse(ui.failedCalled)
    }
    
    func testFailedLoginRoute() throws  {
        presenter.logUser(username: nil, password: nil)
        XCTAssertNil(ui.destination)
    }
    
    func testLoginRoute() throws {
        let username = "something"
        ds.name = username
        presenter.logUser(username: "user", password: "pass")
        XCTAssertNotNil(ui.destination)
        XCTAssertEqual(Route.home(userName: username), ui.destination)
    }
    
    func testRegisterRoute() throws {
        presenter.registerSelected()
        XCTAssertNotNil(ui.destination)
        XCTAssertEqual(Route.register, ui.destination)
    }
}

fileprivate class MockUI: LoginUI {
    var destination: Route!
    var failedCalled = false
    
    func loginFailed(message: String) {
        failedCalled = true
    }
    
    func navigate(to route: Route) {
        destination = route
    }
}
