//
//  AppCoordinator.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import Foundation
import UIKit

public class ApplicationCoordinator: BaseCoordinator {
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private let moduleFactory = ModuleFactoryImp()

    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }

    override public func start() {
       startOffersFlow()
    }

    private func startOffersFlow() {
        
        let offersCoordinator = coordinatorFactory.makeOffersCoordinator(router: router, factory: moduleFactory)
        addChild(offersCoordinator)
        offersCoordinator.start()
//        offersCoordinator.finishFlow = {
//            self.removeChild(offersCoordinator)
//        }
    }

}
