//
//  OffersController.swift
//  proto-lbc
//
//  Created by Benoît Durand on 10/10/2020.
//

import UIKit

protocol OffersView: BaseView {
}

class OffersController: UIViewController, OffersView {
    
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
            
        }
}
