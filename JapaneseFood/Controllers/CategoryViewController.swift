//
//  CategoryViewController.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import UIKit

class CategoryViewController: UIViewController {
    
    
    private var menu:[MenuDetail] = []
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: CategoryViewController.createCompositionalLayout()
        )
        collectionView.register(
            CategoryMenuCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryMenuCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xffE8EDF2)
    
        collectionView.frame = view.frame
        collectionView.backgroundColor = C.cBackGround
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    
    public func configure(with category:Category,cateMenu:[MenuDetail]){
        title = category.catgoryName
        menu = cateMenu
        configureNavigationbar()
    }
    
    
    private static func createCompositionalLayout() -> UICollectionViewCompositionalLayout{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = .init(top: 0, leading: 4, bottom: 5, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(285)
            ),
            subitems:[item,item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 15, bottom: 10, trailing: 15)
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    
    
    private func configureNavigationbar(){
        let leftView = UIButton(type: .system)
        leftView.addTarget(self, action: #selector(back), for: .touchUpInside)
        leftView.backgroundColor = .white
        leftView.layer.cornerRadius = 35 / 2
        leftView.layer.masksToBounds = true
        leftView.tintColor = C.cOrange
        leftView.setImage(
            UIImage(
                systemName: "chevron.backward",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 15,weight: .medium)
            ),
            for: .normal
        )
        leftView.frame = .init(x: 0, y: 0, width: 35, height: 35)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
    }
    
    @objc private func back(){
        navigationController?.popViewController(animated: true)
    }
    
}


extension CategoryViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryMenuCollectionViewCell.identifier, for: indexPath) as? CategoryMenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(withMenu: menu[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryMenuCollectionViewCell
        UIView.animate(
            withDuration: 0.3,
            animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            },
            completion: { _ in
            UIView.animate(withDuration: 0.6) {
                cell.transform = CGAffineTransform.identity
            }
        })
        let vc = FoodDetailViewController()
        vc.configure(with: menu[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

