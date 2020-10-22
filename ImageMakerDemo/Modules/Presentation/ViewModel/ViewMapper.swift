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

public struct DetailViewMapper {
   
    func map(_ model: Pharmacy) -> [String] {
        let mirror = Mirror(reflecting: model)
        var values = [String]()
        for (label, value) in mirror.children {
            guard let label = label else {
                continue
            }
            
            if let string = value as? String {
                values.append(label + ": " + string)
                continue
            }
            
            if let intNumber = value as? Int {
                values.append(label + ": " + String(intNumber))
                continue
            }
            
            if let doubleNumber = value as? Double {
                values.append(label + ": " + String(doubleNumber))
                continue
            }
            
        }
        return values
    }
    
}
