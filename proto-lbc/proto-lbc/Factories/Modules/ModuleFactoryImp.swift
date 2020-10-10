//
//  ModuleFactoryImp.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import Foundation

final class ModuleFactoryImp {}

extension ModuleFactoryImp: OffersModuleFactory {
    func makeOffersController(viewModel: OffersViewModelType) -> OffersView {
        return OffersController(viewModel: viewModel)
    }
}
