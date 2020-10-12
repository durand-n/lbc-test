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
        self.title = "Détails"
        view.backgroundColor = .white
        designView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Retour"

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
        let descriptionLabel = UILabel(title: "Description: ", type: .bold, color: .black, size: 12, lines: 1, alignment: .left)
        let descriptionContentLabel = UILabel(title: viewModel.offerTitle, type: .regular, color: .black, size: 12, lines: 0, alignment: .left)
        let separator = UIView(backgroundColor: UIColor.gray.withAlphaComponent(0.5))
        
        dateLabel.attributedText = viewModel.offerDate
        view.addSubviews([productImageView, separator, titleLabel, priceLabel, dateLabel, categoryLabel, descriptionLabel, descriptionContentLabel])
        
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
        
        priceLabel.setConstraints([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            priceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
        
        descriptionLabel.setConstraints([
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
        ])
        
        descriptionContentLabel.setConstraints([
            descriptionContentLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            descriptionContentLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            descriptionContentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
