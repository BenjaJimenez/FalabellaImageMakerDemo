//
//  RegisterViewController.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerView : UIStackView!
    var titleLabel : UILabel!
    var usernameTextField : UITextField!
    var nameTextField : UITextField!
    var passTextField : UITextField!
    var registerButton: UIButton!
    
    let locator = ServiceLocator()
    var presenter: RegisterPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViews()
        presenter = locator.registerPresenter(ui: self)
    }
    
    fileprivate func loadViews(){
        self.view.backgroundColor = .white
        
        titleLabel = {
            let l = UILabel()
            l.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            l.textAlignment = .center
            l.text = "Register User"
            return l
        }()
    
        usernameTextField = {
            let ut = UITextField()
            ut.placeholder = "Username"
            ut.font = UIFont.systemFont(ofSize: 15)
            ut.borderStyle = .roundedRect
            ut.autocorrectionType = .no
            ut.keyboardType = .default
            ut.returnKeyType = .next
            ut.autocapitalizationType = .none
            ut.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            ut.delegate = self
            return ut
        }()
        
        nameTextField = {
            let nt = UITextField()
            nt.placeholder = "Name"
            nt.font = UIFont.systemFont(ofSize: 15)
            nt.borderStyle = .roundedRect
            nt.autocorrectionType = .no
            nt.keyboardType = .default
            nt.returnKeyType = .next
            nt.autocapitalizationType = .none
            nt.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            nt.delegate = self
            return nt
        }()
        
        passTextField = {
            let pt = UITextField()
            pt.placeholder = "Password"
            pt.font = UIFont.systemFont(ofSize: 15)
            pt.borderStyle = .roundedRect
            pt.autocorrectionType = .no
            pt.isSecureTextEntry = true
            pt.keyboardType = .default
            pt.returnKeyType = .next
            pt.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            pt.delegate = self
            return pt
        }()
        
        registerButton = {
            let b =  UIButton.init(type: .system)
            b.setTitle("Register", for: .normal)
            b.addTarget(self, action: #selector(registerTouched), for: .touchUpInside)
            return b
        }()

        //Stack View
        registerView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis  = NSLayoutConstraint.Axis.vertical
            sv.distribution  = UIStackView.Distribution.equalSpacing
            sv.alignment = UIStackView.Alignment.fill
            sv.spacing = 16.0
            return sv
        }()

        registerView.addArrangedSubview(titleLabel)
        registerView.addArrangedSubview(usernameTextField)
        registerView.addArrangedSubview(nameTextField)
        registerView.addArrangedSubview(passTextField)
        registerView.addArrangedSubview(registerButton)

        self.view.addSubview(registerView)

        //Constraints
        registerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        registerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        registerView.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.8).isActive = true
    }
    
    @objc func registerTouched(){
        presenter?.register(username: usernameTextField.text, name: nameTextField.text, password: passTextField.text)
    }
}

extension RegisterViewController: RegisterUI {
    func registrationMessage(title: String, message: String) {
        
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            nameTextField.becomeFirstResponder()
        case nameTextField:
            passTextField.becomeFirstResponder()
        case passTextField:
            registerTouched()
            passTextField.resignFirstResponder()
        default:
            break
        }
        return true 
    }
}
