//
//  ViewMapper.swift
//  ImageMakerDemo
//
//  Created by Benjamin on 20-10-20.
//

import Foundation

public struct HomeViewMapper {
    func mapAll(_ models: [Pharmacy]) -> [PharmacyCell] {
        var vms = [PharmacyCell]()
        for m in models {
            if let vm = map(m) {
                vms.append(vm)
            }
        }
        return vms
    }
    
    func map(_ model: Pharmacy) -> PharmacyCell? {
        guard let id = model.id, let name = model.name, let address = model.address, let city = model.city else {
            return nil
        }
        
        return PharmacyCell(id: id, name: name, address: address, city: city)
    }
    
}
