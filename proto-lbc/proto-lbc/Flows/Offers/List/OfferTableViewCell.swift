//
//  OfferTableViewCell.swift
//  proto-lbc
//
//  Created by Benoît Durand on 11/10/2020.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    let itemImageView = UIImageView(image: nil, contentMode: .scaleAspectFit)
    let itemNameLabel = UILabel(title: "", type: .semiBold, color: .black, size: 14, lines: 2, alignment: .left)
    let itemPriceLabel = UILabel(title: "", type: .bold, color: .primary, size: 14, lines: 1, alignment: .left)
    let itemCategoryLabel = UILabel(title: "", type: .medium, color: .gray, size: 12, lines: 1, alignment: .left)
    let itemDateLabel = UILabel(title: "", type: .medium, color: .gray, size: 12, lines: 1, alignment: .left)
    let urgentMarker = UILabel(title: "urgent", type: .semiBold, color: .systemRed, size: 10, lines: 0, alignment: .right)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews([itemImageView, itemNameLabel, itemCategoryLabel, itemDateLabel, itemPriceLabel, urgentMarker])
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        itemImageView.backgroundColor = .background
        itemImageView.cornerRadius = 8.0
        itemImageView.setConstraints([
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            itemImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            itemImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -27),
            itemImageView.widthAnchor.constraint(equalToConstant: 72),
            itemImageView.heightAnchor.constraint(equalToConstant: 72),
        ])
        
        itemNameLabel.setConstraints([
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            itemNameLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 16),
            itemNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
        
        itemDateLabel.setConstraints([
            itemDateLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 2),
            itemDateLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 16),
            itemDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
        
        itemCategoryLabel.setConstraints([
            itemCategoryLabel.topAnchor.constraint(equalTo: itemDateLabel.bottomAnchor, constant: 2),
            itemCategoryLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 16),
            itemCategoryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
        
        itemPriceLabel.setConstraints([
            itemPriceLabel.topAnchor.constraint(equalTo: itemCategoryLabel.bottomAnchor, constant: 2),
            itemPriceLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 16),
            itemPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -27),
        ])
        
        urgentMarker.setConstraints([
            urgentMarker.topAnchor.constraint(equalTo: itemCategoryLabel.bottomAnchor, constant: 2),
            urgentMarker.leftAnchor.constraint(equalTo: itemPriceLabel.rightAnchor, constant: 16),
            urgentMarker.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            urgentMarker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -27),
        ])
    }
    
    func setContent(title: String, date: NSAttributedString, category: String, price: String, imageUrl: URL?, isUrgent: Bool) {
        itemNameLabel.text = title
        itemCategoryLabel.text = category
        itemDateLabel.attributedText = date
        itemPriceLabel.text = price
        if let url = imageUrl {
            itemImageView.load(url: url)
        }
        urgentMarker.isHidden = !isUrgent
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
