//
//  UIView.swift
//  proto-lbc
//
//  Created by Benoît Durand on 11/10/2020.
//

import Foundation
import UIKit

extension UIView {
    
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    var cornerRadius: CGFloat? {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue ?? 0
            layer.masksToBounds = (newValue ?? CGFloat(0.0)) > CGFloat(0.0)
        }
    }
    
    func cornerRadius(usingCorners corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            layer.maskedCorners = corners
        }
    }
    
    open func addSubviews(_ views: [UIView]) {
        for i in 0..<views.count {
            addSubview(views[i])
        }
    }
    
    open func removeSubviews() {
        subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    open func fadeIn(withDuration: TimeInterval = 0.2) {
        self.isHidden = false
        UIView.animate(withDuration: withDuration, delay: 0, options: [.curveEaseInOut], animations: {
            self.alpha = 1
        }, completion: nil)
    }
    
    open func fadeOut(withDuration: TimeInterval = 0.2) {
        UIView.animate(withDuration: withDuration, delay: 0, options: [.curveEaseInOut], animations: {
            self.alpha = 0
        }, completion: { _ in
            self.isHidden = true
        })
    }
    
    open func setConstraintsToSuperview() {
        guard let superview = self.superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor),
        ])
    }
    
    open func setConstraints(_ constraints: [NSLayoutConstraint]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
