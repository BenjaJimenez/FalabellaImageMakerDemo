//
//  MockUserDefaults.swift
//  FalabellaImageMakerDemoTests
//
//  Created by Benjamin on 20-10-20.
//

import Foundation

class MockUserDefaults : UserDefaults {
    
    var storedKey: String?
    var storedData: Any?
    
        
    override func value(forKey key: String) -> Any? {
        if key == storedKey{
            return storedData
        }
        return nil
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        storedKey = key
        storedData = value
    }
    
    override func synchronize() -> Bool {
        return true
    }
}
