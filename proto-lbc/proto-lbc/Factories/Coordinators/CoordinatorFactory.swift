//
//  CoordinatorFactory.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import Foundation
import UIKit

protocol CoordinatorFactory {
    func makeOffersCoordinator(router: Router, factory: OffersModuleFactory) -> BaseCoordinator
}
