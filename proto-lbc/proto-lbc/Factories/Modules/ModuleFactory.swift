//
//  ModuleFactory.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import Foundation

protocol OffersModuleFactory {
    func makeOffersListController(viewModel: OffersListViewModelType) -> OffersListView
    func makeOfferDetailsController(viewModel: OfferDetailsViewModelType) -> OfferDetailsView
}
