//
//  HomeTableViewController.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 20-10-20.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
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

    }
    
    @objc func logoutTouched(_ sender: Any?){
        self.presenter?.logoutSelected()
    }
}

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

}
