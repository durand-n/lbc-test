//
//  OffersApiModel.swift
//  proto-lbc
//
//  Created by Benoît Durand on 11/10/2020.
//

import Foundation

class OffersApiModel {
    
    struct Category: Codable, Identifiable {
        var id: Int
        var name: String
    }
    
    struct Item: Codable, Identifiable {
        var id: Int
        var title: String
        var description: String
        var price: Double
        var categoryId: Int
        var imagesUrl: Medias
        var creationDate: Date
        var isUrgent: Bool
        
        private enum CodingKeys: String, CodingKey {
            case id
            case title
            case description
            case price
            case categoryId = "category_id"
            case imagesUrl = "images_url"
            case creationDate = "creation_date"
            case isUrgent = "is_urgent"
        }
    }
    
    struct Medias: Codable {
        var small: String?
        var thumb: String?
        
        private enum CodingKeys: CodingKey {
            case small
            case thumb
        }
    }
}

