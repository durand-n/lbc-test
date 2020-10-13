//
//  UIButton.swift
//  proto-lbc
//
//  Created by Benoît Durand on 13/10/2020.
//

import UIKit

extension UIButton {
    convenience init(color: UIColor) {
        self.init(type: .roundedRect)
        self.backgroundColor = color
        self.cornerRadius = 20.0
    }

    convenience init(illu: UIImage, contentMode: UIView.ContentMode, tintColor: UIColor? = nil) {
        self.init(type: .roundedRect)
        self.setImage(illu, for: .normal)
        self.imageView?.contentMode = contentMode
        if let tintColor = tintColor {
            self.tintColor = tintColor
        }
    }

    internal convenience init(title: String, font: FontType, fontSize: CGFloat = 18, textColor: UIColor, backgroundColor: UIColor? = .clear) {
        self.init(type: .roundedRect)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font.getFontWithSize(fontSize)
        self.titleLabel?.tintColor = textColor
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(title, for: .normal)
    }
}
