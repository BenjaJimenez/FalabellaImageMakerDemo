//
//  LocalDatasource.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation

protocol LocalDatasource {
    func logUser(username: String, password: String)
}

struct UserDefaultsDatasource: LocalDatasource {
    
    func logUser(username: String, password: String) {
        //TODO
    }
    
}
