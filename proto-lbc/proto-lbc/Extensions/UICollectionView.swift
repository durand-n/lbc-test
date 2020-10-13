//
//  UICollectionView.swift
//  proto-lbc
//
//  Created by Benoît Durand on 13/10/2020.
//

import UIKit

extension UICollectionView {
    
    func registerCellClass<T: UICollectionViewCell>(_ className: T.Type) {
        register(className, forCellWithReuseIdentifier: String(describing: className))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as! T
    }
}
