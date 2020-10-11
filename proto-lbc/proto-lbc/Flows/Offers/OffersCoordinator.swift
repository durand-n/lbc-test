//
//  OffersCoordinator.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import UIKit

class OffersCoordinator: BaseCoordinator {
    private let factory: OffersModuleFactory
    private let router: Router
    private let viewModel = OffersViewModel()
    
    init(factory: OffersModuleFactory, router: Router) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showOffersList()
    }
    
    func showOffersList() {
        let module = factory.makeOffersController(viewModel: viewModel)
        module.onShowDetails = { index in
            self.showOfferDetails(itemIndex: index)
        }
        
        self.router.push(module)
    }
    
    func showOfferDetails(itemIndex: Int) {
        
    }
}
