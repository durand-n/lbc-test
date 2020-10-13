//
//  Error.swift
//  proto-lbc
//
//  Created by Benoît Durand on 13/10/2020.
//

import Foundation

extension Error {
    var userFriendly: String {
        switch (self as NSError).code {
        case 3840, 4864:
            return "Les données n'ont pas pu être lues"
        default:
            return "Erreur inconnue"
        }
    }
}
