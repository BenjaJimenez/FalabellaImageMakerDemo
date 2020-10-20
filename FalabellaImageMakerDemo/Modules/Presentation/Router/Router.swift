//
//  Router.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import UIKit

enum Route {
    case register
}

struct Router {
    static func navigate(to route: Route, from vc: UIViewController) {
        switch route {
        case .register:
            let rvc = RegisterViewController()
            vc.present(rvc, animated: true, completion: nil)
        default:
            break
        }
    }
}
