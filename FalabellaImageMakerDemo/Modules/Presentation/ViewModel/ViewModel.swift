//
//  ViewModel.swift
//  FalabellaImageMakerDemo
//
//  Created by Benjamin on 19-10-20.
//

import Foundation

protocol ViewModel {
    var id: String { get set }
}

struct UserViewModel : ViewModel {
    var id: String
}
