//
//  ViewController.swift
//  CollectionView
//
//  Created by Никитин Артем on 3.04.23.
// 2:53

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout! // нужно настраивать отдельно, поэтому мы вынесли его в аутлет
    
    enum Section: Hashable {
        case pinnedItems
        case first
    }
    
    enum Item: Hashable {
        case product(Product.ID)
    }
    
    // РЕГИСТРАЦИЯ ЯЧЕЙКИ
    lazy var itemCellRegistration = UICollectionView
        .CellRegistration<ItemCell, Product.ID> { [weak self] cell, indexPath, itemIdentifier in
            guard let product = self?.products[itemIdentifier] else { return }
            cell.setup(title: product.name, subTitle: "$\(product.price)")
        }
    
    // ДАТА СОРС
    lazy var dataSource = UICollectionViewDiffableDataSource<Section, Item>(
        collectionView: collectionView
    ) { [weak self] collectionView, indexPath, itemIdentifier in
        guard let self else { return UICollectionViewCell() }
        
        switch itemIdentifier {
        case .product(let id):
           return collectionView.dequeueConfiguredReusableCell(using: itemCellRegistration, for: indexPath, item: id)
        }
    }
    
    var productIds: [Product.ID] = []
    var pinnedProductIds: [Product.ID] = []
    var products: [Product.ID: Product] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = itemCellRegistration
        
        /* ЕСЛИ ПРОГРАМНО
        collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         */
        
        // размер ячейки
        collectionViewFlowLayout.itemSize = CGSize(width: 100.0, height: 100.0) // самый быстрый метод
//        collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // самый медленный
    }
    
    private func reloadDataForCollectionView(_ reloadItems: [Item] = []) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([.pinnedItems, .first])
        
        snapshot.appendItems(productIds.map { .product($0) }, toSection: .first)
        
        snapshot.appendItems(pinnedProductIds.map { .product($0) }, toSection: .pinnedItems)
        
        snapshot.reloadItems(reloadItems)
        
        dataSource.apply(snapshot)
    }
    
    private func addNewItems() {
        let newProducts = [
            Product(name: "MilkMilkMilkMilkMilkMilkMilkMilkMilkMilkMilkMilk", price: 2.0),
            Product(name: "Oil", price: 5.0),
            Product(name: "Bread", price: 1.0),
            Product(name: "Meat", price: 9.0),
        ]
        
        // Добавим списку продуктов айдишники
        productIds.append(contentsOf: newProducts.map(\.id))
        products.merge(newProducts.map { ($0.id, $0) }) { $1 }
    }

    
    @IBAction
    func addTapped(_ sender: UIBarButtonItem) {
        addNewItems()
        reloadDataForCollectionView()
    }
}

