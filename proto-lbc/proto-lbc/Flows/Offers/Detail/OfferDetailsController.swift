//
//  OfferDetailsController.swift
//  proto-lbc
//
//  Created by Benoît Durand on 12/10/2020.
//

import UIKit

protocol OfferDetailsView: BaseView {
    
}

class OfferDetailsController: UIViewController, OfferDetailsView {
    // Private properties
    private var viewModel: OfferDetailsViewModelType
    
    init(viewModel: OfferDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        view.backgroundColor = .white
        designView()
    }
    
    func designView() {
        let productImageView = UIImageView(image: nil, contentMode: .scaleAspectFit)
        if let url = viewModel.imageUrl {
            productImageView.load(url: url)
        }
        
        let titleLabel = UILabel(title: viewModel.offerTitle, type: .medium, color: .black, size: 24, lines: 0, alignment: .left)
        let priceLabel = UILabel(title: viewModel.offerPrice, type: .medium, color: .primary, size: 14, lines: 1, alignment: .left)
        let dateLabel = UILabel(title: "", type: .medium, color: .gray, size: 12, lines: 1, alignment: .left)
        let categoryLabel = UILabel(title: viewModel.offerCategory, type: .bold, color: .gray, size: 12, lines: 1, alignment: .left)
        let descriptionLabel = UILabel(title: viewModel.offerTitle, type: .regular, color: .black, size: 12, lines: 0, alignment: .left)
        let separator = UIView(backgroundColor: UIColor.gray.withAlphaComponent(0.5))
        
        dateLabel.attributedText = viewModel.offerDate
        view.addSubviews([productImageView, separator, titleLabel, priceLabel, dateLabel, categoryLabel, descriptionLabel])
        
        productImageView.setConstraints([
            productImageView.topAnchor.constraint(equalTo: view.topAnchor),
            productImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            productImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            productImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        separator.setConstraints([
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.leftAnchor.constraint(equalTo: view.leftAnchor),
            separator.rightAnchor.constraint(equalTo: view.rightAnchor),
            separator.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
        ])
        
        categoryLabel.setConstraints([
            categoryLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
            categoryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            categoryLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        titleLabel.setConstraints([
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 2),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
