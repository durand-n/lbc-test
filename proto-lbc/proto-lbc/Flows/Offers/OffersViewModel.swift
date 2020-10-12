//
//  OffersViewModel.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import UIKit

protocol OffersListViewModelType {
    var title: String { get }
    var offersCount: Int { get }
    func startFetching()
    func getTitleFor(row: Int) -> String
    func getPriceFor(row: Int) -> String
    func getCategoryFor(row: Int) -> String
    func getDateFor(row: Int) -> NSAttributedString
    func getImageUrlFor(row: Int) -> URL?
    func selectOffer(row: Int) -> Bool
    
    
    var onShowError: ((_ message: String) -> Void)? { get set }
    var onShowData: (() -> Void)? { get set }
}

protocol OfferDetailsViewModelType {
    var offerTitle: String { get }
    var offerPrice: String { get }
    var offerCategory: String { get }
    var offerDate: NSAttributedString { get }
    var imageUrl: URL? { get }
}

class OffersViewModel: OffersListViewModelType {
        
    // Private properties
    private let services: OffersApi
    private var categories: [Int: String] = [:]
    private var offers: [OffersApiModel.Item] = []
    private var selectedOffer: OffersApiModel.Item?
    
    // Protocol blocks compliance
    var onShowError: ((_ message: String) -> Void)?
    var onShowData: (() -> Void)?
    
    // init
    init(services: OffersApi = OffersApiImp()) {
        self.services = services
    }
    
    //Protocol properties compliance
    
    var title: String {
        return "\(offers.count) annonces disponibles"
    }
    
    var offersCount: Int {
        return offers.count
    }
    
    func getTitleFor(row: Int) -> String {
        guard row < offers.count else { return "" }
        return offers[row].title
    }
    
    func getPriceFor(row: Int) -> String {
        guard row < offers.count else { return "" }
        return "\(offers[row].price)€"
    }
    
    func getCategoryFor(row: Int) -> String {
        guard row < offers.count else { return "" }
        return self.categories[offers[row].categoryId] ?? ""
    }
    
    func getDateFor(row: Int) -> NSAttributedString {
        guard row < offers.count else { return NSAttributedString(string: "") }
        let date = offers[row].creationDate.string(withFormat: "dd/MM/yyyy")
        let onlineAt = "mis en ligne le \(date)"
        let range = (onlineAt as NSString).range(of: date)

        let attributedString = NSMutableAttributedString.init(string: onlineAt)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        return attributedString
    }
    
    func getImageUrlFor(row: Int) -> URL? {
        guard row < offers.count else { return nil }
        return URL(string: offers[row].imagesUrl.small ?? "")
    }
    
    func startFetching() {
        services.getCategories { categories, error in
            if let categories = categories {
                self.translateToDictionnary(categories)
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
    
    func translateToDictionnary(_ categories: [OffersApiModel.Category]) {
        var newCategories: [Int: String] = [:]
        categories.forEach { category in
            newCategories[category.id] = category.name
        }
        self.categories = newCategories
    }
    
    func selectOffer(row: Int) -> Bool {
        guard row < offers.count else { return false }
        self.selectedOffer = offers[row]
        return true
    }
    

}

extension OffersViewModel: OfferDetailsViewModelType {
    var offerTitle: String {
        guard let selectedOffer = selectedOffer else { return "" }
        return selectedOffer.title
    }
    
    var offerPrice: String {
        guard let selectedOffer = selectedOffer else { return "" }
        return "\(selectedOffer.price)€"
    }
    
    var offerCategory: String {
        guard let selectedOffer = selectedOffer else { return "" }
        return self.categories[selectedOffer.categoryId] ?? ""
    }
    
    var offerDate: NSAttributedString {
        guard let selectedOffer = selectedOffer else { return NSAttributedString(string: "") }
        let date = selectedOffer.creationDate.string(withFormat: "dd/MM/yyyy")
        let onlineAt = "mis en ligne le \(date)"
        let range = (onlineAt as NSString).range(of: date)

        let attributedString = NSMutableAttributedString.init(string: onlineAt)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        return attributedString
        
    }
    
    var imageUrl: URL? {
        guard let selectedOffer = selectedOffer, let url = selectedOffer.imagesUrl.thumb else { return nil }
        return URL(string: url)
    }
    
    
}
