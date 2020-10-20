//
//  HomePresenter.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 20-10-20.
//

import Foundation

public class HomePresenter {
    
    weak var ui: HomeUI?
    
    public init(ui: HomeUI?) {
        self.ui = ui
    }
    
    func logoutSelected(){
        self.ui?.askLogoutConfirmation()
    }
    
    func logoutConfirmed(){
        self.ui?.navigate(to: .back)
    }
}

public protocol HomeUI: class {
    func askLogoutConfirmation()
    func navigate(to route: Route)
}


