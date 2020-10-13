//
//  String.swift
//  proto-lbc
//
//  Created by Benoît Durand on 13/10/2020.
//

import UIKit

extension String {

    public func dateWithFormat(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Calendar.current.locale
        formatter.timeZone = Calendar.current.timeZone
        return formatter.date(from: self)
    }
    
}
