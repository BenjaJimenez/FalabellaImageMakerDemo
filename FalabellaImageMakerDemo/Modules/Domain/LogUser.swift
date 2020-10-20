//
//  LogUser.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation

public struct LogUser {
    
    public var datasource: LocalDatasource
    
    public func log(username: String, password: String) -> String?{
        return datasource.logUser(username: username, password: password)
    }
}
