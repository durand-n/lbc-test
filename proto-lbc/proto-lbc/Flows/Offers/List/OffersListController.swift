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
    
    init(viewModel: OffersListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .white
        designView()
        viewModel.onShowError = self.showError
        viewModel.onShowData = self.onShowData
        Loader.show()
        viewModel.startFetching()
    }
    
    func designView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellClass(OfferTableViewCell.self)
        tableView.backgroundColor = .white
        tableView.separatorColor = UIColor.black.withAlphaComponent(0.2)
        tableView.setConstraintsToSuperview()
    }
    
    func showError(error: String) {
        Loader.hide()
    }
    
    func onShowData() {
        DispatchQueue.main.async {
            self.title = self.viewModel.title
            self.tableView.reloadData()
        }
        
        Loader.hide()
    }
}

extension OffersListController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.offersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: OfferTableViewCell.self)
        cell.setContent(title: viewModel.getTitleFor(row: indexPath.row),
                        date: viewModel.getDateFor(row: indexPath.row),
                        category: viewModel.getCategoryFor(row: indexPath.row),
                        price: viewModel.getPriceFor(row: indexPath.row),
                        imageUrl: viewModel.getImageUrlFor(row: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.selectOffer(row: indexPath.row) else { return }
        self.onShowDetails?()
    }
    
}
