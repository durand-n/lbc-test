//
//  CoordinatorFactoryImp.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import Foundation
import UIKit

class CoordinatorFactoryImp: CoordinatorFactory {
    func makeOffersCoordinator(router: Router, factory: OffersModuleFactory) -> BaseCoordinator {
        return OffersCoordinator(factory: factory, router: router)
    }
    
    // MARK: private
    private func router(_ navController: UINavigationController?) -> Router {
        return RouterImp(rootController: navigationController(navController))
    }
    
    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController } else { return UINavigationController() }
    }
}
