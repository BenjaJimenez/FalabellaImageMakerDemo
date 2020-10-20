//
//  Router.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import UIKit

enum Route {
    case register
    case home(userName: String)
}

struct Router {
    static func navigate(to route: Route, from vc: UIViewController) {
        switch route {
        case .register:
            let rvc = RegisterViewController()
            vc.present(rvc, animated: true, completion: nil)
        case .home(let user):
            print(user)
            break
        default:
            break
        }
    }
}