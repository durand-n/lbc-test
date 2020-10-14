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
        self.title = "LBC"
        view.backgroundColor = .white
        designView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Retour"
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    
    func designView() {
        let productImageView = UIImageView(image: nil, contentMode: .scaleAspectFit)
        
        let titleLabel = UILabel(title: viewModel.offerTitle, type: .bold, color: .secondary, size: 24, lines: 0, alignment: .left)
        let priceLabel = UILabel(title: viewModel.offerPrice, type: .heavy, color: .black, size: 24, lines: 1, alignment: .left)
        let dateLabel = UILabel(title: "", type: .medium, color: .gray, size: 12, lines: 1, alignment: .left)
        let categoryLabel = UILabel(title: viewModel.offerCategory, type: .bold, color: .text, size: 12, lines: 1, alignment: .left)
        let descriptionContentLabel = UILabel(title: viewModel.offerDescription, type: .regular, color: .text, size: 12, lines: 0, alignment: .left)
        let detailsContainer = UIView(backgroundColor: .sand)
        let priceContainer = UIView(backgroundColor: .white)
        let buyButton = UIButton(title: "Contacter", font: .medium, fontSize: 14, textColor: .primary, backgroundColor: .secondary)
        let urgentContainer = UIView(backgroundColor: .urgent)
        let urgentMarker = UILabel(title: "urgent", type: .semiBold, color: .white, size: 10, lines: 0, alignment: .center)
        
        dateLabel.attributedText = viewModel.offerDate
        detailsContainer.addSubviews([titleLabel, dateLabel, categoryLabel, descriptionContentLabel, priceContainer])

        detailsContainer.cornerRadius = 28
        detailsContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        priceContainer.addSubviews([priceLabel, buyButton])
        priceContainer.cornerRadius = 28
        priceContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubviews([productImageView, detailsContainer])
        
        productImageView.setConstraints([
            productImageView.topAnchor.constraint(equalTo: view.topAnchor),
            productImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            productImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            productImageView.bottomAnchor.constraint(greaterThanOrEqualTo: view.centerYAnchor, constant: -150)
        ])
        
        detailsContainer.setConstraints([
            detailsContainer.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 24),
            detailsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailsContainer.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailsContainer.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])

        
        titleLabel.setConstraints([
            titleLabel.topAnchor.constraint(equalTo: detailsContainer.topAnchor, constant: 32),
            titleLabel.leftAnchor.constraint(equalTo: detailsContainer.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: detailsContainer.rightAnchor, constant: -16),
        ])
        
        priceLabel.setConstraints([
            priceLabel.centerYAnchor.constraint(equalTo: priceContainer.centerYAnchor),
            priceLabel.leftAnchor.constraint(equalTo: priceContainer.leftAnchor, constant: 24),
            priceLabel.rightAnchor.constraint(equalTo: priceContainer.centerXAnchor)
        ])
        
        buyButton.cornerRadius = 17.5
        buyButton.setConstraints([
            buyButton.heightAnchor.constraint(equalToConstant: 35),
            buyButton.rightAnchor.constraint(equalTo: detailsContainer.rightAnchor, constant: -16),
            buyButton.centerYAnchor.constraint(equalTo: priceContainer.centerYAnchor),
            buyButton.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        categoryLabel.setConstraints([
            categoryLabel.topAnchor.constraint(equalTo: descriptionContentLabel.bottomAnchor, constant: 16),
            categoryLabel.leftAnchor.constraint(equalTo: detailsContainer.leftAnchor, constant: 16),
            categoryLabel.rightAnchor.constraint(equalTo: detailsContainer.rightAnchor, constant: -16),
        ])
        
        dateLabel.setConstraints([
            dateLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            dateLabel.leftAnchor.constraint(equalTo: detailsContainer.leftAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: priceContainer.topAnchor, constant: -24)
        ])
        
        descriptionContentLabel.setConstraints([
            descriptionContentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionContentLabel.leftAnchor.constraint(equalTo: detailsContainer.leftAnchor, constant: 16),
            descriptionContentLabel.rightAnchor.constraint(equalTo: detailsContainer.rightAnchor, constant: -16),
        
        ])
        
        priceContainer.setConstraints([
            priceContainer.bottomAnchor.constraint(equalTo: detailsContainer.bottomAnchor),
            priceContainer.leftAnchor.constraint(equalTo: detailsContainer.leftAnchor),
            priceContainer.rightAnchor.constraint(equalTo: detailsContainer.rightAnchor),
            priceContainer.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        
        if viewModel.isUrgent {
            detailsContainer.addSubview(urgentContainer)
            urgentContainer.setConstraints([
                urgentContainer.heightAnchor.constraint(equalToConstant: 20),
                urgentContainer.widthAnchor.constraint(equalToConstant: 45),
                urgentContainer.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 8),
                urgentContainer.rightAnchor.constraint(equalTo: detailsContainer.rightAnchor, constant: -16),
                urgentContainer.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor)
            ])
            
            urgentContainer.addSubview(urgentMarker)
            urgentMarker.setConstraintsToSuperview()
            urgentContainer.cornerRadius = 6
        }
        
        view.layoutIfNeeded()

        if let url = viewModel.imageUrl {
            productImageView.load(url: url)
            productImageView.alpha = 1.0
        } else {
            productImageView.image =  #imageLiteral(resourceName: "noPicture")
            productImageView.alpha = 0.1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
