//
//  proto_lbcTests.swift
//  proto-lbcTests
//
//  Created by Benoît Durand on 10/10/2020.
//

import XCTest
@testable import proto_lbc

class OffersTestApi: OffersApi {
    func getListing(completion: @escaping ([OffersApiModel.Item]?, Error?) -> Void) {
        completion([], nil)
    }
    
    func getCategories(completion: @escaping ([OffersApiModel.Category]?, Error?) -> Void) {
        completion([], nil)
    }
}

class OffersViewModelTests: XCTestCase {
    private var viewModel: OffersViewModelType = OffersViewModel(services: OffersTestApi())
    
    
    func testOffersTitle() throws {
        XCTAssertEqual(viewModel.title, "0 items available")
    }
}
