//
//  Constants.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import Foundation
import UIKit

struct Constants {
    static let SERVER_URL = "​https://raw.githubusercontent.com/leboncoin/paperclip/master"
}

struct Loader {
    static let contentView = UIView(backgroundColor: UIColor.black.withAlphaComponent(0.5))
    static let spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    static func show() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            window.addSubviews([contentView, spinner])
            contentView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: window.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                contentView.leftAnchor.constraint(equalTo: window.leftAnchor),
                contentView.rightAnchor.constraint(equalTo: window.rightAnchor),
            ])
            
            spinner.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                spinner.widthAnchor.constraint(equalToConstant: 64),
                spinner.heightAnchor.constraint(equalToConstant: 64),
                spinner.centerYAnchor.constraint(equalTo: window.centerYAnchor),
                spinner.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            ])
            
            spinner.startAnimating()
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            spinner.stopAnimating()
            contentView.removeFromSuperview()
            spinner.removeFromSuperview()
        }
    }
}
