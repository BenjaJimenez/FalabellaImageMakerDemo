//
//  LoginPresenter.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation

public class LoginPresenter {
    
    weak var ui: LoginUI?
    
    init(ui: LoginUI) {
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
        
        
    }
}

protocol LoginUI: class {
    func loginFailed(message: String)
    func displayHome(data: String)
    
}

fileprivate struct Constant {
    static let noUserOrPassword = "No username or password"
    static let invalidUserOrPassword = "Wrong username or password"
}
