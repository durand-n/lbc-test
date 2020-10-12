//
//  UIImageView.swift
//  proto-lbc
//
//  Created by Benoît Durand on 12/10/2020.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode cm: UIView.ContentMode) {
        self.init(image: image)
        self.contentMode = cm
    }
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
