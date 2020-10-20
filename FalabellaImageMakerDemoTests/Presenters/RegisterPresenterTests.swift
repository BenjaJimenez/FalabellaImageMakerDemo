//
//  RegisterPresenterTests.swift
//  FalabellaImageMakerDemoTests
//
//  Created by Benjamin on 20-10-20.
//

import XCTest
@testable import FalabellaImageMakerDemo

class RegisterPresenterTests: XCTestCase {
    
    var presenter: RegisterPresenter!
    var ds: MockUserDefaultsDatasource!
    fileprivate var ui: MockUI!
    
    override func setUpWithError() throws {
        ui = MockUI()
        ds = MockUserDefaultsDatasource()
        let useCase = RegisterUser(datasource: ds)
        presenter = RegisterPresenter(registerUser: useCase, ui: ui)
    }
    
    func testRegisterInvalidFields() throws {
        
        presenter.register(username: nil, name: nil, password: nil)
        XCTAssertFalse(ds.registerCalled)
        XCTAssertEqual(ui.title, "Error")
        ui.title = nil
        
        presenter.register(username: "", name: "", password: "")
        XCTAssertFalse(ds.registerCalled)
        XCTAssertEqual(ui.title, "Error")
        ui.title = nil
        
        presenter.register(username: "un", name: "na", password: nil)
        XCTAssertFalse(ds.registerCalled)
        XCTAssertEqual(ui.title, "Error")
        ui.title = nil
        
        presenter.register(username: "un", name: nil, password: "ps")
        XCTAssertFalse(ds.registerCalled)
        XCTAssertEqual(ui.title, "Error")
        ui.title = nil
        
        presenter.register(username: nil, name: "na", password: "ps")
        XCTAssertFalse(ds.registerCalled)
        XCTAssertEqual(ui.title, "Error")
    }

    func testRegisterValidFields() throws {
        presenter.register(username: "un", name: "na", password: "ps")
        XCTAssertTrue(ds.registerCalled)
        XCTAssertEqual(ui.title, "Success")
    }
}

fileprivate class MockUI :RegisterUI {
    var title: String? = nil
    func registrationMessage(title: String, message: String) {
        self.title = title
    }
}

