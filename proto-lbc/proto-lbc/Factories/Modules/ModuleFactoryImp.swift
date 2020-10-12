//
//  ModuleFactoryImp.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import Foundation

final class ModuleFactoryImp {}

extension ModuleFactoryImp: OffersModuleFactory {
    
    func makeOffersListController(viewModel: OffersListViewModelType) -> OffersListView {
        return OffersListController(viewModel: viewModel)
    }
    
    func makeOfferDetailsController(viewModel: OfferDetailsViewModelType) -> OfferDetailsView {
        return OfferDetailsController(viewModel: viewModel)
    }
}
