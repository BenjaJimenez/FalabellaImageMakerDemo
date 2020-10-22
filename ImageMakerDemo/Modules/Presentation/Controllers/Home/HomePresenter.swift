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
    
    func loadData(query: String? = nil, limit: Int? = nil) {
        getPharmacies.get(keyword: query, limit: limit) { [weak self] response in
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
    
    func searchData(query: String?, limit: String?){
        if let limit = limit, !limit.isEmpty, Int(limit) == nil {
            ui?.displayMessage(title: Constant.error, message: Constant.invalidLimit)
            return
        }
        loadData(query: query, limit: Int(limit ?? ""))
    }
    
    func mapResults(_ pharmacies: [Pharmacy]){
        guard pharmacies.count > 0 else {
            ui?.displayMessage(title: Constant.error, message: Constant.noResults)
            return
        }
        
        let vms = mapper.mapAll(pharmacies)
        if vms.count > 0 {
            ui?.displayPharmacies(vms)
        }else {
            ui?.displayMessage(title: Constant.error, message: Constant.invalidData)
        }
    }
    
    func pharmacySelected(id: String){
        guard let pharmacy = pharmacies.first(where: {$0.id == id}) else {
            ui?.displayMessage(title: Constant.error, message: Constant.invalidData)
            return
        }
        self.ui?.navigate(to: .detail(pharmacy: pharmacy))
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
    func displayMessage(title: String, message: String)
}

fileprivate struct Constant {
    static let error = "Error"
    static let noResults = "No data was received"
    static let invalidData = "Invalid data received"
    static let invalidLimit = "Limit has to be a number"
    static let pharmacyNotFound = "Limit has to be a number"
}

