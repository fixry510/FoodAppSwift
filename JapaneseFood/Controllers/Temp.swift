//
//  Temp.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//



import Foundation
//
//  CartDetailViewController.swift
//  MyFirstProjectNew
//
//  Created by Pin Sukjaroen on 2/6/2567 BE.
//

//import UIKit
//import Combine
//
//class CartDetailViewController: UIViewController {
//
//
//    private var cartCollectionView: UICollectionView!
//
//    private var cancellables: Set<AnyCancellable> = []
//
//    private let summaryCartView: CartSummaryView = CartSummaryView()
//
//    private var mainCollectionView: UICollectionView!
//
//    var timer: Timer?
//    var imageNo:Int = 0
//
//    private let miniImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//
//    private let emptyCartLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Cart is empty"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.isHidden = true
//        label.textColor = .secondaryLabel
//        return label
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "Cart Detail"
//        view.backgroundColor = .white
//        summaryCartView.delegate = self
//        createLayout()
//        createCartCollectionView()
//        configureNavigationbar()
//        configureConstraints()
//        bindViewModel()
//    }
//
//
//    private func createLayout(){
//        let itemSize = NSCollectionLayoutItem(
//            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//        )
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)),
//            subitems: [itemSize]
//        )
//        let section = NSCollectionLayoutSection(group: group)
//        mainCollectionView = UICollectionView(
//            frame: .zero,
//            collectionViewLayout: UICollectionViewCompositionalLayout(section: section)
//        )
//        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(mainCollectionView)
//    }
//
//    private func configureConstraints(){
//        NSLayoutConstraint.activate([
//            cartCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            cartCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            cartCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            cartCollectionView.bottomAnchor.constraint(equalTo: summaryCartView.topAnchor,constant: -10),
//
//            emptyCartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            emptyCartLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 150),
//
//            summaryCartView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
//            summaryCartView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
//            summaryCartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            summaryCartView.heightAnchor.constraint(equalToConstant: 170),
//        ])
//    }
//
//
//    private func configureNavigationbar(){
//        let customView = UIView()
//        miniImage.image = UIImage(named: "food-logo1")
//        customView.addSubview(miniImage)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            customView: customView
//        )
//        customView.translatesAutoresizingMaskIntoConstraints = false
//        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        miniImage.frame = .init(x: customView.center.x, y: customView.center.y, width: 40, height: 40)
//
//        let leftView = UIButton(type: .system)
//        leftView.addTarget(self, action: #selector(back), for: .touchUpInside)
//        leftView.backgroundColor = .white
//        leftView.layer.cornerRadius = 35 / 2
//        leftView.layer.masksToBounds = true
//        leftView.tintColor = C.cOrange
//        leftView.setImage(
//            UIImage(
//                systemName: "chevron.backward",
//                withConfiguration: UIImage.SymbolConfiguration(pointSize: 15,weight: .medium)
//            ),
//            for: .normal
//        )
//        leftView.frame = .init(x: 0, y: 0, width: 35, height: 35)
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            customView: leftView
//        )
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
//    }
//
//    @objc func timerFired() {
//        let images:[String] = [
//            "food-logo2",
//            "food-logo3",
//            "food-logo4",
//            "food-logo5",
//            "food-logo1",
//        ]
//        imageNo = imageNo + 1
//        if imageNo > 4  {
//            imageNo = 0
//        }
//        miniImage.image = UIImage(named: images[imageNo])
//
//    }
//
//
//    private func createCartCollectionView(){
//        let flowLayout = UICollectionViewFlowLayout()
//        cartCollectionView = UICollectionView(
//            frame: .zero,
//            collectionViewLayout: flowLayout
//        )
//        cartCollectionView.register(CartItemCellCollectionViewCell.self, forCellWithReuseIdentifier: CartItemCellCollectionViewCell.identifier)
//        cartCollectionView.translatesAutoresizingMaskIntoConstraints = false
//
//        flowLayout.itemSize = .init(width: view.frame.width - 30, height: 90)
//        flowLayout.scrollDirection = .vertical
//        flowLayout.sectionInset = .init(top: 30, left: 0, bottom: 30, right: 0)
//
//
//        cartCollectionView.collectionViewLayout = flowLayout
//
//        cartCollectionView.dataSource = self
//        cartCollectionView.delegate = self
//        view.addSubviews(cartCollectionView,emptyCartLabel,summaryCartView)
//    }
//
//
//
//
//    @objc private func back(){
//        navigationController?.popViewController(animated: true)
//    }
//
//
//    private func bindViewModel(){
//        OrderProvider.shared.$carts.sink { carts in
//            if carts.isEmpty {
//                self.emptyCartLabel.isHidden = false
//            }else{
//                self.emptyCartLabel.isHidden = true
//            }
//        }.store(in: &cancellables)
//    }
//
//}
//
//
//extension CartDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//       return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return OrderProvider.shared.carts.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard  let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: CartItemCellCollectionViewCell.identifier,
//            for: indexPath
//        ) as? CartItemCellCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        cell.configure(withCart: OrderProvider.shared.carts[indexPath.row])
//        cell.delegate = self
//        return cell
//    }
//
//}
//
//
//
//extension CartDetailViewController: CartItemCellCollectionViewCellDelegate,CartSummaryViewDelegate{
//
//    func didDeleteCartItem() {
//        self.cartCollectionView.reloadData()
//    }
//
//    func didTapContinue() {
//        let vc = UIViewController()
//        vc.view.backgroundColor = .white
//        if let sheet = vc.sheetPresentationController {
//            let customDetent = UISheetPresentationController.Detent.custom { context in
//                return UIScreen.main.bounds.height * 0.6
//            }
//            sheet.detents = [customDetent]
//            sheet.prefersGrabberVisible = false
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//        }
//        present(vc, animated: true)
//    }
//}
//

