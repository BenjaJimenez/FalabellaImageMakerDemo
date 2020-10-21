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
    
    func homePresenter(ui: HomeUI?) -> HomePresenter{
        return HomePresenter(getPharmacies: getPharmacies, mapper: HomeViewMapper(), ui: ui)
    }

// MARK: - Use Cases
    
    var logUser: LogUser {
        return LogUser(datasource: localDatasource)
    }
    
    var registerUser: RegisterUser {
        return RegisterUser(datasource: localDatasource)
    }
    
    var getPharmacies: GetPharmacies {
        GetPharmacies(datasource: minsalDatasource)
    }
    
// MARK: - Datasource
    
    var localDatasource: UserDatasource {
        return UserDefaultsDatasource(userDefaults: UserDefaults.standard)
    }
    
    var minsalDatasource: MinsalDatasource {
        return MinsalDatasource()
    }
}
