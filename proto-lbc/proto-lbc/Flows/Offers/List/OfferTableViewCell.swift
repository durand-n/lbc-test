//
//  OfferTableViewCell.swift
//  proto-lbc
//
//  Created by Benoît Durand on 11/10/2020.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    let itemImageView = UIImageView(image: nil, contentMode: .scaleAspectFit)
    let itemNameLabel = UILabel(title: "", type: .semiBold, color: .text, size: 14, lines: 2, alignment: .left)
    let itemPriceLabel = UILabel(title: "", type: .bold, color: .secondary, size: 14, lines: 1, alignment: .left)
    let itemCategoryLabel = UILabel(title: "", type: .medium, color: .gray, size: 12, lines: 1, alignment: .left)
    let itemDateLabel = UILabel(title: "", type: .medium, color: .gray, size: 12, lines: 1, alignment: .left)
    let urgentContainer = UIView(backgroundColor: .urgent)
    let urgentMarker = UILabel(title: "urgent", type: .semiBold, color: .white, size: 10, lines: 0, alignment: .center)
    let container = UIView(backgroundColor: .white)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(container)
        contentView.backgroundColor = .clear
        container.addSubviews([itemImageView, itemNameLabel, itemCategoryLabel, itemDateLabel, itemPriceLabel, urgentContainer])
        urgentContainer.addSubview(urgentMarker)
        backgroundColor = .clear
        selectionStyle = .none
        
        container.addShadow(offset: CGSize(width: 0, height: 5), color: .black, opacity: 0.2, radius: 5)
//        container.addShadow(offset: CGSize(width: 0, height: 10))
        container.cornerRadius = 16
        container.setConstraints([
            container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
        
        itemImageView.backgroundColor = .background
        itemImageView.cornerRadius = 8.0
        itemImageView.setConstraints([
            itemImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16).withPriority(750),
            itemImageView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 16),
            itemImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            itemImageView.widthAnchor.constraint(equalToConstant: 72),
            itemImageView.heightAnchor.constraint(equalToConstant: 72),
        ])
        
        itemNameLabel.setConstraints([
            itemNameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            itemNameLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 16),
            itemNameLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16),
            itemNameLabel.bottomAnchor.constraint(equalTo: itemDateLabel.topAnchor, constant: 2)
        ])
        
        itemDateLabel.setConstraints([
            itemDateLabel.topAnchor.constraint(equalTo: itemImageView.centerYAnchor, constant: -8),
            itemDateLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 16),
            itemDateLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16),
        ])
        
        itemCategoryLabel.setConstraints([
            itemCategoryLabel.topAnchor.constraint(equalTo: itemDateLabel.bottomAnchor, constant: 2),
            itemCategoryLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 16),
            itemCategoryLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16),
        ])
        
        itemPriceLabel.setConstraints([
            itemPriceLabel.topAnchor.constraint(equalTo: itemCategoryLabel.bottomAnchor, constant: 2),
            itemPriceLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 16),
            itemPriceLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
        ])
        
        urgentContainer.setConstraints([
            urgentContainer.heightAnchor.constraint(equalToConstant: 20),
            urgentContainer.widthAnchor.constraint(equalToConstant: 45),
            urgentContainer.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16),
            urgentContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
        ])
        
        urgentMarker.setConstraintsToSuperview()
        urgentContainer.cornerRadius = 6
        
    
    }
    
    func setContent(title: String, date: NSAttributedString, category: String, price: String, imageUrl: URL?, isUrgent: Bool) {
        itemNameLabel.text = title
        itemCategoryLabel.text = category
        itemDateLabel.attributedText = date
        itemPriceLabel.text = price
        itemImageView.image = nil
        if let url = imageUrl {
            itemImageView.load(url: url)
        }
        urgentContainer.isHidden = !isUrgent
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
