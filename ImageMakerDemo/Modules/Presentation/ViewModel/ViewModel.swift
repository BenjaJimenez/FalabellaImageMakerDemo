//
//  ViewModel.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation

public protocol ViewModel {
    var id: String { get set }
}

struct UserViewModel : ViewModel {
    var id: String
}

public struct PharmacyCell : ViewModel {
    public var id: String
    var name: String
    var address: String
    var city: String
    
}
