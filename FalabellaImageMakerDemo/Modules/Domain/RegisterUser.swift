//
//  RegisterUser.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation

struct RegisterUser {
    
    var datasource: LocalDatasource
    
    func register(username: String, name: String, password: String) -> Bool{
        return datasource.register(username: username, name: name, password: password)
        
    }
}
