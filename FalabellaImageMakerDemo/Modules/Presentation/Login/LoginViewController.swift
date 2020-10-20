//
//  LoginViewController.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import UIKit

class LoginViewController: UIViewController {

    var loginView : UIStackView!
    var titleLabel: UILabel!
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
        
        titleLabel = {
            let l = UILabel()
            l.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            l.textAlignment = .center
            l.text = "Welcome!"
            return l
        }()
        
        usernameTextField = {
            let mt = UITextField()
            mt.placeholder = "Username"
            mt.font = UIFont.systemFont(ofSize: 15)
            mt.borderStyle = .roundedRect
            mt.autocorrectionType = .no
            mt.keyboardType = .emailAddress
            mt.autocapitalizationType = .none
            mt.returnKeyType = .next
            mt.delegate = self
            mt.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            return mt
        }()
        
        passTextField = {
            let pt = UITextField()
            pt.placeholder = "Password"
            pt.font = UIFont.systemFont(ofSize: 15)
            pt.borderStyle = .roundedRect
            pt.autocorrectionType = .no
            pt.isSecureTextEntry = true
            pt.keyboardType = .default
            pt.returnKeyType = .done
            pt.delegate = self
            pt.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            return pt
        }()
        
        loginButton = {
            let b =  UIButton.init(type: .system)
            b.setTitle("Login", for: .normal)
            b.addTarget(self, action: #selector(loginButtonTouched), for: .touchUpInside)
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

        loginView.addArrangedSubview(titleLabel)
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
    
    @objc func loginButtonTouched(){
        self.presenter?.logUser(username: usernameTextField.text, password: passTextField.text)
    }
    
    @objc func registerButtonTouched(){
        self.presenter?.registerSelected()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passTextField.becomeFirstResponder()
        case passTextField:
            loginButtonTouched()
            passTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}

extension LoginViewController: LoginUI {
    func navigate(to route: Route) {
        Router.navigate(to: route, from: self)
    }
    
    func loginFailed(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

