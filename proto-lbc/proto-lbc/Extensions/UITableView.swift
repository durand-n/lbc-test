//
//  UITableView.swift
//  proto-lbc
//
//  Created by Benoît Durand on 11/10/2020.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: name)) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, reuseId: String) -> T {
        return dequeueReusableCell(withIdentifier: reuseId) as! T
    }
    
    func registerCellClass<T: UITableViewCell>(_ className: T.Type) {
        register(className, forCellReuseIdentifier: String(describing: className))
    }
    
    func setEmptyStateView(_ emptyState: UIView) {
        let emptyStateView = UIView(backgroundColor: .clear)
        emptyStateView.addSubview(emptyState)
        emptyState.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyState.leftAnchor.constraint(equalTo: emptyStateView.leftAnchor),
            emptyState.rightAnchor.constraint(equalTo: emptyStateView.rightAnchor),
            emptyState.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor),
            emptyState.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
        ])
        
        self.isScrollEnabled = false
//        self.separatorStyle = .none
    }
    
    func removeEmptyStateView() {
        backgroundView = nil
//        separatorStyle = .singleLine
    }
}
