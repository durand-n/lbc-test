//
//  OffersListController.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import UIKit

protocol OffersListView: BaseView {
    var onShowDetails: (() -> Void)? { get set }
}

class OffersListController: UIViewController, OffersListView {
    // Protocol compliance
    var onShowDetails: (() -> Void)?
    
    // Private properties
    private var viewModel: OffersListViewModelType
    private var tableView = UITableView()
    private var filtersModule: FilterCollection
    private var emptyView = UIView(backgroundColor: .white)
    private var offersCountLabel = UILabel(title: "", type: .bold, color: .black, size: 20, lines: 1, alignment: .left)
    
    init(viewModel: OffersListViewModelType) {
        self.viewModel = viewModel
        self.filtersModule = FilterCollection(viewModel: viewModel as! FilterCollectionViewModelType)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LBC"
        offersCountLabel.text = self.viewModel.title
        view.backgroundColor = .white
        designView()
        viewModel.onShowError = self.showError
        viewModel.onShowData = self.onShowData
        Loader.show()
        viewModel.startFetching()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .sand
        self.navigationItem.title = "LBC"
    }

    
    func designView() {
        let emptyStateLabel = UILabel(title: "Aucune annonce disponible", type: .bold, color: .black, size: 14, lines: 0, alignment: .center)
        let emptyStateRetry = UIButton(title: "Rafraichir", font: .medium, fontSize: 12, textColor: .primary, backgroundColor: .clear)
        
        view.backgroundColor = .sand
        view.addSubviews([offersCountLabel, filtersModule, tableView, emptyView])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellClass(OfferTableViewCell.self)
        tableView.backgroundColor = .sand
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableView.automaticDimension
        
        offersCountLabel.setConstraints([
            offersCountLabel.topAnchor.constraint(equalTo: view.topAnchor),
            offersCountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            offersCountLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            offersCountLabel.heightAnchor.constraint(equalToConstant: 27)
        ])
        
        filtersModule.setConstraints([
            filtersModule.topAnchor.constraint(equalTo: offersCountLabel.bottomAnchor),
            filtersModule.leftAnchor.constraint(equalTo: view.leftAnchor),
            filtersModule.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        tableView.setConstraints([
            tableView.topAnchor.constraint(equalTo: filtersModule.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        emptyView.setConstraintsToSuperview()
        emptyStateRetry.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        emptyView.addSubviews([emptyStateLabel, emptyStateRetry])
        
        
        emptyStateLabel.setConstraints([
            emptyStateLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor),
            emptyStateLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)
        ])
        
        emptyStateRetry.setConstraints([
            emptyStateRetry.leftAnchor.constraint(equalTo: emptyView.leftAnchor),
            emptyStateRetry.rightAnchor.constraint(equalTo: emptyView.rightAnchor),
            emptyStateRetry.topAnchor.constraint(equalTo: emptyStateLabel.bottomAnchor, constant: 4),
            emptyStateRetry.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func showError(error: String) {
        Loader.hide()
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func onShowData(refreshFilters: Bool = false) {
        DispatchQueue.main.async {
            self.offersCountLabel.text = self.viewModel.title
            self.tableView.reloadData()
            self.filtersModule.refreshFilters()
        }
        
        Loader.hide()
    }
    
    @objc func refreshData() {
        viewModel.startFetching()
    }
}

extension OffersListController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let offersCount = viewModel.offersCount
        if offersCount == 0 {
            emptyView.fadeIn()
        } else {
            emptyView.fadeOut()
        }
        return viewModel.offersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: OfferTableViewCell.self)
        cell.setContent(title: viewModel.getTitleFor(row: indexPath.row),
                        date: viewModel.getDateFor(row: indexPath.row),
                        category: viewModel.getCategoryFor(row: indexPath.row),
                        price: viewModel.getPriceFor(row: indexPath.row),
                        imageUrl: viewModel.getImageUrlFor(row: indexPath.row),
                        isUrgent: viewModel.isUrgentFor(row: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.selectOffer(row: indexPath.row) else { return }
        self.onShowDetails?()
    }
    
}
