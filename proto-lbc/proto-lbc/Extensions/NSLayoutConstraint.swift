//
//  NSLayoutConstraint.swift
//  proto-lbc
//
//  Created by Benoît Durand on 13/10/2020.
//

import UIKit

public extension NSLayoutConstraint {
    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(priority)
        return self
    }
}
