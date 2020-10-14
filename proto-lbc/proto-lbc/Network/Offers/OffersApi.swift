//
//  OffersApi.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import Foundation

enum OffersApiRoutes {
    case Listing
    case Categories
}

extension OffersApiRoutes {
    var path: String {
        switch self {
        case .Listing:
            return "\(Constants.SERVER_URL)/listing.json"
        case .Categories:
            return "\(Constants.SERVER_URL)/categories.json"
        }
    }
}

protocol OffersApi {
    func getListing(completion: @escaping (_ items: [OffersApiModel.Item]? ,_ error: Error?) -> Void)
    func getCategories(completion: @escaping (_ categories: [OffersApiModel.Category]?, _ error: Error?) -> Void)
}

class OffersApiImp: OffersApi {
    func getListing(completion: @escaping ([OffersApiModel.Item]? ,Error?) -> Void) {
        if let url = URL(string: OffersApiRoutes.Listing.path) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let items = try decoder.decode([OffersApiModel.Item].self, from: data)
                        completion(items, error)
                    } catch let error {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, error)
                }
           }.resume()
        } else {
            completion(nil, nil)
        }
    }
    
    func getCategories(completion: @escaping ([OffersApiModel.Category]?, Error?) -> Void) {
        if let url = URL(string: OffersApiRoutes.Categories.path) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let categories = try decoder.decode([OffersApiModel.Category].self, from: data)
                        completion(categories, error)
                    } catch let error {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, error)
                }
           }.resume()
        } else {
            completion(nil, nil)
        }
    }
}
