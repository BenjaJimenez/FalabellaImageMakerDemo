//
//  UserDefaultsDatasource.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation
import CryptoSwift

public protocol UserDatasource {
    func logUser(username: String, password: String) -> String?
    func register(username: String, name: String, password: String) -> Bool
}

public protocol CipherDatasource {
    func decrypt(data: Data, password: String) -> String?
    func encrypt(storeKey: String, value: String, password: String) -> Data?
}

public struct UserDefaultsDatasource: UserDatasource, CipherDatasource {
    
    
    var userDefaults: UserDefaults
    
    public func logUser(username: String, password: String) -> String? {
        guard let data = userDefaults.value(forKey: username) as? Data else {
            return nil
        }
        
        return decrypt(data: data,password: password)
    }
    
    public func register(username: String, name: String, password: String) -> Bool {
        guard userDefaults.value(forKey: username) == nil else {
            // Value already exists
            return false
        }
        guard let data = encrypt(storeKey: username, value: name, password: password) else {
            return false
        }
        
        userDefaults.setValue(data, forKey: username)
        userDefaults.synchronize()
        return true
    }
    
    public func decrypt(data: Data, password: String) -> String? {
        
        guard let kdf = kdf(pass: password) else {
            return nil
        }
        
        do {
            let decrypted = try AES(key: kdf, blockMode: CBC(iv: Constant.iv), padding: .pkcs7).decrypt(data.bytes)
            let token = String(bytes:decrypted, encoding:String.Encoding.utf8)
            return token
        } catch let error {
            print(error)
        }
        return nil
    }
    
    public func encrypt(storeKey: String, value: String, password: String) -> Data? {
        do {
            guard let kdf = kdf(pass: password) else {
                return nil
            }
            let aes = try AES(key: kdf, blockMode: CBC(iv: Constant.iv))
            let ciphertext = try aes.encrypt(Array(value.utf8))

            return Data(ciphertext)
        } catch let error {
            print(error)
        }
        return nil
    }
    
    
    fileprivate func kdf(pass: String) ->[UInt8]?{
        let password: Array<UInt8> = Array(pass.utf8)
        let salt: Array<UInt8> = Array(Constant.salt.utf8)

        do {
            let key = try PKCS5.PBKDF2(password: password, salt: salt, iterations: 10, keyLength: 32, variant: .sha256).calculate()
            return key
        } catch let error {
            print(error)
        }
        return nil
    }
}

fileprivate struct Constant {
    static let iv = Array("0123456789012345".utf8)
    static let salt = "saltsaltsalt"
}


