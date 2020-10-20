//
//  LogUser.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation

struct LogUser {
    
    var datasource: LocalDatasource
    
    func log(username: String, password: String) -> String?{
        return datasource.logUser(username: username, password: password)
    }
}
