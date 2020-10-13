//
//  FilterModule.swift
//  proto-lbc
//
//  Created by Benoît Durand on 12/10/2020.
//

import UIKit

protocol FilterCollectionViewModelType {
    var activeFiltersCount: Int { get }
    var filtersCount: Int { get }
    
    func activeFilterNameAt(row: Int) -> String
    func availableFilterNameAt(row: Int) -> String
    func deselectFilter(row: Int)
    func selectFilter(row: Int)
    
}



class FilterCollection: UIView {
    private let viewModel: FilterCollectionViewModelType
    private let collectionView: UICollectionView
    private var layout = UICollectionViewFlowLayout()
    
    init(viewModel: FilterCollectionViewModelType) {
        self.viewModel = viewModel
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        layout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCellClass(FilterCollectionCell.self)
        designView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func designView() {
        self.addSubview(collectionView)
        collectionView.setConstraintsToSuperview()
        collectionView.backgroundColor = .sand
        
        self.setConstraints([
            self.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func refreshFilters() {
        collectionView.reloadData()
    }
}

extension FilterCollection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? viewModel.activeFiltersCount : viewModel.filtersCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: FilterCollectionCell.self, indexPath: indexPath)
        cell.setContent(title: indexPath.section == 0 ? viewModel.activeFilterNameAt(row: indexPath.row) : viewModel.availableFilterNameAt(row: indexPath.row), isActive: indexPath.section == 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.performBatchUpdates({
            indexPath.section == 0 ? viewModel.deselectFilter(row: indexPath.row) : viewModel.selectFilter(row: indexPath.row)

            collectionView.deleteItems(at: [indexPath])
            collectionView.insertItems(at: [IndexPath(row: collectionView.numberOfItems(inSection: 1 - indexPath.section), section: 1 - indexPath.section)])
        }, completion: nil)
        

        collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
    }
}

class FilterCollectionCell: UICollectionViewCell {
    private var filterLabel = UILabel(title: "", type: .bold, color: .black, size: 12, lines: 1, alignment: .center)
    private let container = UIView(backgroundColor: .background)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        container.addSubview(filterLabel)
        contentView.addSubview(container)
        
        filterLabel.setConstraints([
            filterLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 16),
            filterLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -16),
            filterLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            filterLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5)
        ])
        
        container.setConstraints([
            container.heightAnchor.constraint(equalToConstant: 30).withPriority(750),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            container.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
        
        container.cornerRadius = 12
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(title: String, isActive: Bool) {
        filterLabel.text = title
        filterLabel.textColor = isActive ? .secondary : .black
        isActive ? container.addShadow(offset: CGSize(width: 0, height: 5), color: .black, opacity: 0.2, radius: 5) : container.removeShadow()
    }
}
