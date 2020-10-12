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
        let backgroundView = UIView(backgroundColor: .clear)
        backgroundView.addSubview(emptyState)
        emptyState.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyState.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 16),
            emptyState.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -16),
            emptyState.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            emptyState.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
        ])
        self.backgroundView = backgroundView
        self.separatorStyle = .none
    }
    
    func removeEmptyStateView() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
    
    func reloadWithAnimation() {
        self.reloadData()
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            for view in cell.contentView.subviews {
                view.alpha = 0
                view.transform = CGAffineTransform(translationX: 0, y: 20)
                UIView.animate(withDuration: 0.5, delay: 0.08 * Double(delayCounter), usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    view.transform = CGAffineTransform.identity
                    view.alpha = 1.0
                }, completion: nil)
                delayCounter += 1
            }
        }
    }
}
