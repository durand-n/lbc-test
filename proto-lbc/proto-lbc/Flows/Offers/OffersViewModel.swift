//
//  OffersViewModel.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import Foundation

protocol OffersViewModelType {
    var title: String { get }
    func startFetching()
    
    var onShowError: ((_ message: String) -> Void)? { get set }
    var onShowData: (() -> Void)? { get set }
}

class OffersViewModel: OffersViewModelType {
    // Private properties
    private let services: OffersApi
    private var categories: [OffersApiModel.Category] = []
    private var offers: [OffersApiModel.Item] = []
    
    // Protocol compliance
    var onShowError: ((_ message: String) -> Void)?
    var onShowData: (() -> Void)?
    
    init(services: OffersApi = OffersApiImp()) {
        self.services = services
    }
    
    func startFetching() {
        services.getCategories { categories, error in
            if let categories = categories {
                self.categories = categories
                self.services.getListing { items, error in
                    if let items = items {
                        self.offers = items
                        self.onShowData?()
                    } else {
                        self.onShowError?(error?.localizedDescription ?? "unknown error")
                    }
                }
            } else {
                self.onShowError?(error?.localizedDescription ?? "unknown error")
            }
        }
    }
    
    func refreshOffersList() {
        services.getListing { items, error in
            if let items = items {
                self.offers = items
                self.onShowData?()
            } else {
                self.onShowError?(error?.localizedDescription ?? "unknown error")
            }
        }
    }
    
    var title: String {
        return "\(offers.count) items available"
    }
}
