//
//  LoginPresenter.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation

public class LoginPresenter {
    
    var logUser: LogUser
    weak var ui: LoginUI?
    
    init(logUser: LogUser, ui: LoginUI?) {
        self.logUser = logUser
        self.ui = ui
    }
    
    func logUser(username: String?, password: String?){
        guard let username = username, let password = password else {
            ui?.loginFailed(message: Constant.noUserOrPassword)
            return
        }
        
        guard username.count > 0, password.count > 0 else {
            ui?.loginFailed(message: Constant.noUserOrPassword)
            return
        }
        
        guard let name = logUser.log(username: username, password: password) else {
            ui?.loginFailed(message: Constant.invalidUserOrPassword)
            return
        }
        
        print(name)
                
    }
    
    func registerSelected() {
        self.ui?.navigate(to: .register)
    }
}

protocol LoginUI: class {
    func loginFailed(message: String)
    func navigate(to route: Route)
}

fileprivate struct Constant {
    static let noUserOrPassword = "No username or password"
    static let invalidUserOrPassword = "Wrong username or password"
}
