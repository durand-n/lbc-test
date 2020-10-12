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
        let module = factory.makeOffersListController(viewModel: viewModel)
        module.onShowDetails = self.showOfferDetails
        
        self.router.push(module)
    }
    
    func showOfferDetails() {
        let module = factory.makeOfferDetailsController(viewModel: viewModel)
        self.router.push(module)
    }
}
