//
//  ServiceLocator.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation

struct ServiceLocator {
    
// MARK: - Presenters
    func registerPresenter(ui: RegisterUI?) -> RegisterPresenter{
        return RegisterPresenter(registerUser: registerUser, ui: ui)
    }
    
    func loginPresenter(ui: LoginUI?) -> LoginPresenter{
        return LoginPresenter(logUser: logUser, ui: ui)
    }

// MARK: - Use Cases
    
    var logUser: LogUser {
        return LogUser(datasource: localDatasource)
    }
    
    var registerUser: RegisterUser {
        return RegisterUser(datasource: localDatasource)
    }
    
// MARK: - Datasource
    
    var localDatasource: LocalDatasource {
        return UserDefaultsDatasource()
    }
}
