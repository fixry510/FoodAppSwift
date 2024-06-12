//
//  CartSummaryItemsViewController.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import UIKit

class CartSummaryItemsViewController: UIViewController {

    
    public var cartCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCartCollectionView()
        configureConstraints()
        cartCollectionView.delegate = self
    }
    
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            cartCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            cartCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func createCartCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        cartCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        cartCollectionView.register(CartItemCellCollectionViewCell.self, forCellWithReuseIdentifier: CartItemCellCollectionViewCell.identifier)
        cartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        flowLayout.itemSize = .init(width: view.frame.width - 30, height: 90)
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = .init(top: 30, left: 0, bottom: 30, right: 0)
        cartCollectionView.collectionViewLayout = flowLayout
        cartCollectionView.dataSource = self
        cartCollectionView.delegate = self
        view.addSubview(cartCollectionView)
    }
    
}


extension CartSummaryItemsViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OrderProvider.shared.carts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CartItemCellCollectionViewCell.identifier,
            for: indexPath
        ) as? CartItemCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(withCart: OrderProvider.shared.carts[indexPath.row])
        cell.delegate = self
        return cell
    }
    
}

extension CartSummaryItemsViewController: CartItemCellCollectionViewCellDelegate{
    
    func didDeleteCartItem() {
        self.cartCollectionView.reloadData()
    }
    
}



