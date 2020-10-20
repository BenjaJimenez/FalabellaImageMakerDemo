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
    }
    
    @objc func logoutTouched(_ sender: Any?){
        self.presenter?.logoutSelected()
    }
}

extension HomeTableViewController: HomeUI {
    
    
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
}
