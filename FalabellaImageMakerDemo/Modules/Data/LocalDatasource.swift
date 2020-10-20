//
//  LocalDatasource.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation
import CryptoSwift

protocol LocalDatasource {
    func logUser(username: String, password: String) -> String?
    func register(username: String, name: String, password: String) -> Bool
}

struct UserDefaultsDatasource: LocalDatasource {
    
    func logUser(username: String, password: String) -> String? {
        guard let data = UserDefaults.standard.value(forKey: username) as? Data else {
            return nil
        }
        
        guard let key = kdf(pass: password) else {
            return nil
        }
        
        do {
            let decrypted = try AES(key: key, blockMode: CBC(iv: Constant.iv), padding: .pkcs7).decrypt(data.bytes)
            let token = String(bytes:decrypted, encoding:String.Encoding.utf8)
            return token
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func register(username: String, name: String, password: String) -> Bool {
        do {
            guard let key = kdf(pass: password) else {
                return false
            }
            let aes = try AES(key: key, blockMode: CBC(iv: Constant.iv))
            let ciphertext = try aes.encrypt(Array(name.utf8))

            UserDefaults.standard.setValue(Data(ciphertext), forKey: username)
            UserDefaults.standard.synchronize()
            return true
        } catch let error {
            print(error)
        }
        return false
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


