//
//  Router.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import UIKit

public enum Route: Equatable {    
    case register
    case home(userName: String)
    case detail(pharmacy: Pharmacy)
        
    case back
}

public struct Router {
    static func navigate(to route: Route, from vc: UIViewController) {
        switch route {
        case .register:
            let rvc = RegisterViewController()
            vc.present(rvc, animated: true, completion: nil)
        case .home(let user):
            let hvc = HomeTableViewController()
            hvc.name = user
            let nv = UINavigationController(rootViewController: hvc)
            nv.modalPresentationStyle = .fullScreen
            vc.present(nv, animated: true, completion: nil)
        case .detail(pharmacy: let pharmacy):
            let dvc = DetailViewController()
            let locator = ServiceLocator()
            dvc.presenter = locator.detailPresenter(pharmacy: pharmacy, ui: dvc)
            if let nv = vc.navigationController {
                nv.pushViewController(dvc, animated: true)
            }else {
                vc.present(dvc, animated: true, completion: nil)
            }
        case .back:
            vc.dismiss(animated: true, completion: nil)
        }
    }
}
