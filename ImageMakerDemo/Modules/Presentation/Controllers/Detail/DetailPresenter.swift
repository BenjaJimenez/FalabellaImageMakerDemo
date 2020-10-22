//
//  DetailPresenter.swift
//  ImageMakerDemo
//
//  Created by Benjamin on 21-10-20.
//

import Foundation

public class DetailPresenter {
    
    var pharmacy: Pharmacy
    var mapper: DetailViewMapper
    weak var ui: DetailUI?
    
    init(pharmacy: Pharmacy, mapper: DetailViewMapper, ui: DetailUI?) {
        self.pharmacy = pharmacy
        self.mapper = mapper
        self.ui = ui
    }
    
    func displayData(){
        let values = self.mapper.map(pharmacy)
        if values.count > 0 {
            self.ui?.displayList(values: self.mapper.map(pharmacy))
        }else {
            self.ui?.displayError(message: Constants.invalidPharmacy)
        }
    }
    
}

public protocol DetailUI: class {
    func displayList(values: [String])
    func displayError(message: String)
}

fileprivate struct Constants {
    static let invalidPharmacy = "Invalid Data"
}


