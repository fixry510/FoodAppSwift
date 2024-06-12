//
//  HeaderView.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import UIKit
import Combine

protocol HederViewDelegate:AnyObject {
    func didSelectCategory(_ category:Category)
    func didChangeSearchMenu(_ text:String)
}


class HeaderView: UICollectionReusableView {
    
    
    public weak var deletegate:HederViewDelegate?
    
   
    
    public var categories:[Category] = []
    
    private let butttonsFilter:[UIButton] = {
        let buttons: [UIButton] = ["Categories","Price","Rating","Recommanded"].map { filter in
            let button = UIButton(type: .system)
            button.configuration = .bordered()
            button.configuration?.titleLineBreakMode = .byTruncatingTail
            button.configuration?.baseBackgroundColor =  UIColor(rgb: 0xffE8EDF2)
            button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{ incoming in
                var outgoing = incoming
                outgoing.font = UIFont.systemFont(ofSize: 14)
                return outgoing
            }
            button.configuration?.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
            button.setTitle(filter, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.black, for: .highlighted)
            button.layer.cornerRadius = 35.0 / 2.0
            button.layer.borderColor = UIColor.systemGray4.cgColor
            button.layer.borderWidth = 1
            button.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            button.heightAnchor.constraint(equalToConstant: 35).isActive = true
            button.layer.masksToBounds = true
            return button
        }
        return buttons
    }()
    
    let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .bordered()
        button.configuration?.baseBackgroundColor =  UIColor(rgb: 0xffE8EDF2)
        button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer{ incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 14)
            return outgoing
        }
        button.configuration?.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        button.setImage(
            UIImage(
                systemName: "slider.horizontal.3",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 14)
            ),
            for: .normal
        )
        button.tintColor = .black
        button.layer.cornerRadius = 35.0 / 2.0
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.borderWidth = 1
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.masksToBounds = true
        return button
    }()
    
    
    private let categoriesView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = .init(width: 80, height: 80)
        flow.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: flow)
        collectionView.backgroundColor =  UIColor(rgb: 0xffE8EDF2)
        collectionView.register(
            CategoryCellCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCellCollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let bannerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner2")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //        scrollView.backgroundColor = .red
        return scrollView
    }()
    
    private lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(
            bannerImage,
            categoriesView,
            scrollView,
            stackView
        )
        stackView.addArrangedSubview(filterButton)
        butttonsFilter.forEach { stackView.addArrangedSubview($0) }
        scrollView.addSubview(stackView)
        backgroundColor = UIColor(rgb: 0xffE8EDF2)
        categoriesView.dataSource = self
        categoriesView.delegate = self
        configureConstraints()
    }
    
    
    @objc private func searchTextChange(_ textField:UITextField){
        if let text = textField.text {
            deletegate?.didChangeSearchMenu(text)
        }
    }
    
    public func configureCategories(with categories:[Category]){
        self.categories = categories
        categoriesView.reloadData()
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            bannerImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            bannerImage.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            bannerImage.heightAnchor.constraint(equalToConstant: 130),
            
            categoriesView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            categoriesView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            categoriesView.topAnchor.constraint(equalTo: bannerImage.bottomAnchor,constant: 20),
            categoriesView.heightAnchor.constraint(equalToConstant: 180),
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: categoriesView.bottomAnchor,constant: 5),
            scrollView.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 15),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    
 
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}


extension HeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCellCollectionViewCell.identifier, for: indexPath) as? CategoryCellCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: categories[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deletegate?.didSelectCategory(categories[indexPath.row])
    }
}

