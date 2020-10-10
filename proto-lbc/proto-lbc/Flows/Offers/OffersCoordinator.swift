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
    
    init(factory: OffersModuleFactory, router: Router) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        let module = factory.makeOffersController(viewModel: OffersViewModel())
        self.router.push(module)
    }
}
