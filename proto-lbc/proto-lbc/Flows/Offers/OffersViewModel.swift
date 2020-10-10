//
//  OffersViewModel.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import Foundation

protocol OffersViewModelType {
    var title: String { get }
}

class OffersViewModel: OffersViewModelType {
    init() {
        
    }
    
    var title: String {
        return "Hello World"
    }
}
