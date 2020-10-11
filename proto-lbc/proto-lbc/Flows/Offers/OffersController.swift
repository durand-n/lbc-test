//
//  OffersController.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import UIKit

protocol OffersView: BaseView {
    var onShowDetails: ((_ index: Int) -> Void)? { get set }
}

class OffersController: UIViewController, OffersView {
    // Protocol compliance
    var onShowDetails: ((Int) -> Void)?
    
    // Private properties
    private var viewModel: OffersViewModelType
    private var tableView = UITableView()
    
    init(viewModel: OffersViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .primary
        viewModel.onShowError = self.showError
        viewModel.onShowData = self.onShowData
        Loader.show()
        viewModel.startFetching()
    }
    
    func showError(error: String) {
        Loader.hide()
    }
    
    func onShowData() {
        DispatchQueue.main.async {
            self.title = self.viewModel.title
        }
        Loader.hide()
    }
}
