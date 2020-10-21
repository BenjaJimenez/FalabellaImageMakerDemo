//
//  HomePresenter.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 20-10-20.
//

import Foundation

public class HomePresenter {
    
    var getPharmacies : GetPharmacies
    var mapper: HomeViewMapper
    weak var ui: HomeUI?
    
    var pharmacies = [Pharmacy]()
    
    public init(getPharmacies : GetPharmacies, mapper: HomeViewMapper, ui: HomeUI?) {
        self.getPharmacies = getPharmacies
        self.mapper = mapper
        self.ui = ui
        loadData()
    }
    
    func loadData() {
        getPharmacies.get { [weak self] response in
            guard let self = self else {
                return
            }
            
            if let pharmacies = response {
                self.pharmacies = pharmacies
                OperationQueue.main.addOperation {
                    self.mapResults(pharmacies)
                }
            }
        }
    }
    
    func mapResults(_ pharmacies: [Pharmacy]){
        let vms = self.mapper.mapAll(pharmacies)
        if vms.count > 0 {
            self.ui?.displayPharmacies(vms)
        }
    }
    
    func logoutSelected(){
        self.ui?.askLogoutConfirmation()
    }
    
    func logoutConfirmed(){
        self.ui?.navigate(to: .back)
    }
}

public protocol HomeUI: class {
    func displayPharmacies(_ pharmacies: [PharmacyCell])
    func askLogoutConfirmation()
    func navigate(to route: Route)
}


