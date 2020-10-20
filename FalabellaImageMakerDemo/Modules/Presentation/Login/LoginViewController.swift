//
//  LoginViewController.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import UIKit

class LoginViewController: UIViewController {

    var loginView : UIStackView!
    var usernameTextField : UITextField!
    var passTextField : UITextField!
    var loginButton: UIButton!
    var registerButton: UIButton!
    
    let locator = ServiceLocator()
    var presenter: LoginPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadViews()
        presenter = locator.loginPresenter(ui: self)
    }
    
    fileprivate func loadViews(){
        self.view.backgroundColor = .white
        
        usernameTextField = {
            let mt = UITextField()
            mt.placeholder = "Username"
            mt.font = UIFont.systemFont(ofSize: 15)
            mt.borderStyle = UITextField.BorderStyle.roundedRect
            mt.autocorrectionType = UITextAutocorrectionType.no
            mt.keyboardType = UIKeyboardType.default
            mt.returnKeyType = UIReturnKeyType.next
            mt.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            return mt
        }()
        
        passTextField = {
            let pt = UITextField()
            pt.placeholder = "Password"
            pt.font = UIFont.systemFont(ofSize: 15)
            pt.borderStyle = UITextField.BorderStyle.roundedRect
            pt.autocorrectionType = UITextAutocorrectionType.no
            pt.isSecureTextEntry = true
            pt.keyboardType = UIKeyboardType.emailAddress
            pt.returnKeyType = UIReturnKeyType.next
            pt.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            return pt
        }()
        
        loginButton = {
            let b =  UIButton.init(type: .system)
            b.setTitle("Login", for: .normal)
            return b
        }()
        
        registerButton = {
            let b =  UIButton.init(type: .system)
            b.setTitle("Register", for: .normal)
            b.addTarget(self, action: #selector(registerButtonTouched), for: .touchUpInside)
            return b
        }()

        //Stack View
        loginView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis  = NSLayoutConstraint.Axis.vertical
            sv.distribution  = UIStackView.Distribution.equalSpacing
            sv.alignment = UIStackView.Alignment.fill
            sv.spacing = 16.0
            return sv
        }()

        loginView.addArrangedSubview(usernameTextField)
        loginView.addArrangedSubview(passTextField)
        loginView.addArrangedSubview(loginButton)
        loginView.addArrangedSubview(registerButton)

        self.view.addSubview(loginView)

        //Constraints
        loginView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loginView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8).isActive = true
    }
    
    
    @objc func registerButtonTouched(){
        self.presenter?.registerSelected()
    }
}

extension LoginViewController: LoginUI {
    func navigate(to route: Route) {
        Router.navigate(to: route, from: self)
    }
    
    func loginFailed(message: String) {
        //TODO:
    }
}

