//
//  HomeViewController.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import UIKit
import Alamofire
import Combine


class HomeViewController: UIViewController {
    
//    private let viewModel = MyFirstViewViewModel()
    
    
    private var categories:[Category] = []
    private var allMenuDetailItems:[MenuDetail]  = []
    private var displayMenuDetailItems:[MenuDetail] = []
    
    var selectedIndexPath:IndexPath!
    
    private let searchBarView = SearchBarView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width - 25, height: 125)
        layout.minimumLineSpacing = 25
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
        collectionView.register(
            MenuItemCollectionViewCell.self,
            forCellWithReuseIdentifier: MenuItemCollectionViewCell.identifier
        )
        collectionView.backgroundColor = UIColor(rgb: 0xffE8EDF2)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResources()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor(rgb: 0xffE8EDF2)
//        view.backgroundColor = .yellow
        view.addSubviews(searchBarView,collectionView)
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        searchBarView.delegate = self
        view.addGestureRecognizer(tap)
        
        configureConstraints()
        
    }
    
    private func fetchResources(){
        AF.request("http://192.168.1.38:3000/categories",method: .get).response { res in
            switch res.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode([Category].self, from: data!)
                    self.categories = jsonData
                    print(self.categories.count)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("failed")
                print(error)
            }
        }
        AF.request("http://192.168.1.38:3000/",method: .get).response { res in
            switch res.result {
            case .success(let data):
                do {
                    let jsonData = try JSONDecoder().decode([MenuDetail].self, from: data!)
                    self.allMenuDetailItems = jsonData
                    self.displayMenuDetailItems = self.allMenuDetailItems
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("failed")
                print(error)
            }
        }
    }
    
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBarView.heightAnchor.constraint(equalToConstant: 125),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}


extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayMenuDetailItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCollectionViewCell.identifier, for: indexPath) as? MenuItemCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.configure(with: displayMenuDetailItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header",
            for: indexPath
        ) as! HeaderView
        headerView.configureCategories(with: self.categories)
        headerView.deletegate = self
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(
            width: collectionView.bounds.width,
            height: searchBarView.searchTextField.text != "" ? 0 :  335 + 60
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        let vc = FoodDetailViewController()
        vc.configure(with:  displayMenuDetailItems[indexPath.row])
         navigationController?.pushViewController(vc, animated: true)
    }
    
    func selectedFoodImage() -> UIImageView  {
        let cell = collectionView.cellForItem(at: selectedIndexPath) as! MenuItemCollectionViewCell
        return  cell.menuImageView
        
    }
}


extension HomeViewController: HederViewDelegate {
    
    func didSelectCategory(_ category: Category) {
        let vc = CategoryViewController()
        let cateMenu = allMenuDetailItems.filter{$0.catgoryId == category.catgoryId}
        vc.configure(with: category,cateMenu: cateMenu)
        navigationController?.pushViewController(vc, animated: true)
        print("Category \(category.catgoryName) was selected")
    }
    
    
}

extension HomeViewController: SearchBarViewDelegate {
    
    
    func didChangeSearchMenu(_ text: String) {
        if text.isEmpty {
            displayMenuDetailItems = allMenuDetailItems
        }else{
            displayMenuDetailItems = displayMenuDetailItems.filter{$0.foodName.lowercased().contains(text.lowercased())}
        }
        collectionView.reloadData()
    }
    
    func didTapCartButton() {
        let vc = CartDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}





