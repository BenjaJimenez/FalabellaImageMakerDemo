//
//  RegisterPresenter.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation

class RegisterPresenter {
    
    var registerUser: RegisterUser
    weak var ui: RegisterUI?
    
    init(registerUser: RegisterUser, ui: RegisterUI?) {
        self.registerUser = registerUser
        self.ui = ui
    }
    
    func register(username: String?, name:String?, password: String?){
        guard let username = username, let name = name, let pass = password else {
            self.ui?.registrationMessage(title: Constant.error, message: Constant.allFields)
            return
        }
        
        guard username.count > 0, name.count > 0, pass.count > 0 else {
            self.ui?.registrationMessage(title: Constant.error, message: Constant.allFields)
            return
        }
        
        if registerUser.register(username: username, name: name, password: pass) {
            self.ui?.registrationMessage(title: Constant.success, message: Constant.registrationCompleted)
        }else {
            self.ui?.registrationMessage(title: Constant.error, message: Constant.userError)
        }
    }
}

protocol RegisterUI: class {
    func registrationMessage(title: String, message: String)
}

fileprivate struct Constant {
    static let error = "Error"
    static let allFields = "You have to complete all fields"
    static let userError = "Can't register user"
    static let success = "Success"
    static let registrationCompleted = "The user was registrated"
}
