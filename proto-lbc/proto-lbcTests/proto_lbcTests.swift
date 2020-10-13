//
//  proto_lbcTests.swift
//  proto-lbcTests
//
//  Created by Benoît Durand on 10/10/2020.
//

import XCTest
@testable import proto_lbc
typealias Cat = OffersApiModel.Category
typealias Offer = OffersApiModel.Item

class OffersTestApi: OffersApi {
    var offers: [OffersApiModel.Item]
    var categories: [OffersApiModel.Category]
    
    init(offers: [Offer], categories: [Cat]) {
        self.offers = offers
        self.categories = categories
    }
    
    func getListing(completion: @escaping ([Offer]?, Error?) -> Void) {
        completion(offers, nil)
    }
    
    func getCategories(completion: @escaping ([Cat]?, Error?) -> Void) {
        completion(categories, nil)
    }
}

class OffersListViewModelTests: XCTestCase {
    private var viewModel: OffersListViewModelType = OffersViewModel(services: OffersTestApi(offers: [Offer(id: 1, title: "Peugeot 208", description: "", price: 5000.0, categoryId: 3, imagesUrl: OffersApiModel.Medias(small: nil, thumb: nil), creationDate: "12/12/2010".dateWithFormat(format: "dd/MM/yyyy")!, isUrgent: false),
                                                                                                      Offer(id: 1, title: "Smart 1999", description: "128", price: 5000.0, categoryId: 3, imagesUrl: OffersApiModel.Medias(small: nil, thumb: nil), creationDate: "22/09/2018".dateWithFormat(format: "dd/MM/yyyy")!, isUrgent: true),
                                                                                                      Offer(id: 1, title: "meuble sdb", description: "123", price: 10.5, categoryId: 2, imagesUrl: OffersApiModel.Medias(small: nil, thumb: nil), creationDate: "5/10/2020".dateWithFormat(format: "dd/MM/yyyy")!, isUrgent: false)],
                                                                                             categories: [Cat(id: 3, name: "Voiture"), Cat(id: 2, name: "Maison")]))
    
    override func setUp() {
        viewModel.startFetching()
    }
    
    
    func testOffersTitle() throws {
        XCTAssertEqual(viewModel.title, "3 annonces disponibles")
    }
    
    func testOffersCount() throws {
        XCTAssertEqual(viewModel.offersCount, 3)
    }
    
    func testOrder() throws {
        XCTAssertEqual(viewModel.isUrgentFor(row: 0), true)
        XCTAssertEqual(viewModel.getTitleFor(row: 1), "meuble sdb")
        XCTAssertEqual(viewModel.getTitleFor(row: 2), "Peugeot 208")
    }
    
    func testFields() throws {
        print(viewModel.getDateFor(row: 0))
        print(viewModel.getDateFor(row: 1))
        print(viewModel.getDateFor(row: 2))
        XCTAssertEqual(viewModel.getTitleFor(row: 0), "Smart 1999")
        XCTAssertEqual(viewModel.getTitleFor(row: 12), "")
        XCTAssertEqual(viewModel.isUrgentFor(row: 1), false)
        XCTAssertEqual(viewModel.isUrgentFor(row: 0), true )
        XCTAssertEqual(viewModel.getPriceFor(row: 2), "5000€")
        XCTAssertEqual(viewModel.getCategoryFor(row: 0), "Voiture")
        XCTAssertEqual(viewModel.getDateFor(row: 0).string, "Mis en ligne le 22/09/2018")
        
    }
}

class OfferDetailsViewModelTests: XCTestCase {
    private var viewModel: OfferDetailsViewModelType = OffersViewModel(services: OffersTestApi(offers: [Offer(id: 1, title: "testItem", description: "", price: 50.0, categoryId: 3, imagesUrl: OffersApiModel.Medias(small: nil, thumb: nil), creationDate: Date(), isUrgent: false)], categories: [Cat(id: 3, name: "Voiture")]))
    
    override func setUp() {
        (viewModel as! OffersListViewModelType).startFetching()
        _ = (viewModel as! OffersListViewModelType).selectOffer(row: 0)
    }
    
    func testDetails() {
        XCTAssertEqual(viewModel.offerTitle, "testItem")
        XCTAssertEqual(viewModel.offerPrice, "50€")
        XCTAssertEqual(viewModel.offerCategory, "Voiture")
        XCTAssertEqual(viewModel.offerDate.string, "Mis en ligne le \(Date().string(withFormat: "dd/MM/yyyy"))")
    }
    
    
}

class FilterCollectionViewModelTests: XCTestCase {
    private var viewModel: FilterCollectionViewModelType & OffersListViewModelType = OffersViewModel(services: OffersTestApi(offers: [Offer(id: 1, title: "testItem", description: "", price: 50.0, categoryId: 3, imagesUrl: OffersApiModel.Medias(small: nil, thumb: nil), creationDate: Date(), isUrgent: false),
                                                                                                            Offer(id: 1, title: "testItemBis", description: "128", price: 5000.0, categoryId: 3, imagesUrl: OffersApiModel.Medias(small: nil, thumb: nil), creationDate: Date(), isUrgent: false),
                                                                                                            Offer(id: 1, title: "testAgain", description: "123", price: 10.5, categoryId: 2, imagesUrl: OffersApiModel.Medias(small: nil, thumb: nil), creationDate: Date(), isUrgent: false)],
                                                                                                   categories: [Cat(id: 3, name: "Voiture"), Cat(id: 2, name: "Maison")]))
    
    override func setUp() {
        viewModel.startFetching()
    }
    
    func testFilters() {
        XCTAssertEqual(viewModel.filtersCount, 2)
        XCTAssertEqual(viewModel.activeFiltersCount, 0)
        viewModel.selectFilter(row: 0)
        XCTAssertEqual(viewModel.activeFilterNameAt(row: 0), "Maison")
        XCTAssertEqual(viewModel.activeFiltersCount, 1)
        XCTAssertEqual(viewModel.filtersCount, 1)
        viewModel.selectFilter(row: 0)
        XCTAssertEqual(viewModel.activeFilterNameAt(row: 0), "Maison")
        XCTAssertEqual(viewModel.filtersCount, 0)
        XCTAssertEqual(viewModel.activeFiltersCount, 2)
        viewModel.deselectFilter(row: 0)
        XCTAssertEqual(viewModel.filtersCount, 1)
        XCTAssertEqual(viewModel.activeFilterNameAt(row: 0), "Voiture")
    }
}
