//
//  HomeTableViewController.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 20-10-20.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var queryTextfield: UITextField!
    var limitTextfield: UITextField!
    var searchButton: UIButton!
    
    let locator = ServiceLocator()
    var presenter: HomePresenter?
    var name : String?
    
    var pharmacies = [PharmacyCell]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViews()
        presenter = locator.homePresenter(ui: self)
        
    }
    
    func loadViews() {
        if let name = name {
            self.title = "Welcome " + name
        }
        
        let barButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTouched(_ :)))
        self.navigationItem.setRightBarButton(barButton, animated: true)
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        queryTextfield = {
            let qt = UITextField()
            qt.placeholder = "Search"
            qt.font = UIFont.systemFont(ofSize: 15)
            qt.borderStyle = .roundedRect
            qt.autocorrectionType = .no
            qt.keyboardType = .alphabet
            qt.autocapitalizationType = .none
            qt.returnKeyType = .next
//            mt.delegate = self
            qt.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            qt.delegate = self
            return qt
        }()
        
        limitTextfield = {
            let lt = UITextField()
            lt.placeholder = "Limit"
            lt.font = UIFont.systemFont(ofSize: 15)
            lt.borderStyle = .roundedRect
            lt.autocorrectionType = .no
            lt.keyboardType = .numberPad
            lt.returnKeyType = .search
//            pt.delegate = self
            lt.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            lt.widthAnchor.constraint(equalToConstant: 50).isActive = true
            lt.delegate = self
            return lt
        }()
        
        searchButton = {
            let b =  UIButton(type: .system)
            b.setTitle("Search", for: .normal)
            b.addTarget(self, action: #selector(searchButtonTouched(_:)), for: .touchUpInside)
            b.tintColor = .white
            b.widthAnchor.constraint(equalToConstant: 50).isActive = true
            return b
        }()
        
        let stackView : UIStackView = {
            let sv = UIStackView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis  = .horizontal
            sv.distribution  = UIStackView.Distribution.fillProportionally
            sv.alignment = UIStackView.Alignment.center
            sv.spacing = 8
            return sv
        }()
        
        stackView.addArrangedSubview(queryTextfield)
        stackView.addArrangedSubview(limitTextfield)
        stackView.addArrangedSubview(searchButton)
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50))
        view.backgroundColor = .darkGray
        view.addSubview(stackView)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[stackView]|", options: .alignAllBottom, metrics: nil, views: ["stackView": stackView]));
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[stackView]-|", options: .alignAllBottom, metrics: nil, views: ["stackView": stackView]));
        
        self.tableView.tableHeaderView = view
        
        var tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)

    }
    
    @objc func logoutTouched(_ sender: Any?){
        self.presenter?.logoutSelected()
    }
    
    @objc func searchButtonTouched(_ sender: Any? = nil){
        print("Search")
        self.presenter?.searchData(query: queryTextfield.text, limit: limitTextfield.text)
    }
}

// MARK: - UI Protocol

extension HomeTableViewController: HomeUI {
    
    func displayPharmacies(_ pharmacies: [PharmacyCell]) {
        self.pharmacies = pharmacies
        self.tableView.reloadData()
    }
    
    func navigate(to route: Route) {
        Router.navigate(to: route, from: self)
    }
    
    func askLogoutConfirmation() {
        let alert = UIAlertController(title: "¿Do you want to logout?", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { (action) in
            self.presenter?.logoutConfirmed()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - tableView Delegates

extension HomeTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pharmacies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! HomeTableViewCell
        let data = pharmacies[indexPath.row]
        cell.configure(data)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = pharmacies[indexPath.row]
        presenter?.pharmacySelected(id: item.id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - textfield Delegate

extension HomeTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if queryTextfield.isFirstResponder {
            limitTextfield.becomeFirstResponder()
        }else if limitTextfield.isFirstResponder {
            limitTextfield.resignFirstResponder()
            searchButtonTouched()
        }
        return true
    }
}


// MARK: - TapGesture Delegate

extension HomeTableViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return false
    }
}
