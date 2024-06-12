//
//  CartItemCellCollectionViewCell.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import SDWebImage
import Combine


protocol CartItemCellCollectionViewCellDelegate:AnyObject {
    func didDeleteCartItem()
}


class CartItemCellCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CartItemCellCollectionViewCell"
    
    private var cart:CartItem!
    
    var delegate:CartItemCellCollectionViewCellDelegate?
    
    var currentX:Double?
    
    
    private var cartItemViewModel:CartItemViewModel!
    var cancel = Set<AnyCancellable>()
    
    private let foodImage:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let foodNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16,weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12,weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "plus",withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = C.cOrange
        button.layer.cornerRadius = 25.0 / 2.0
        return button
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "minus",withConfiguration: configuration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = C.cOrange
        button.layer.cornerRadius = 25.0 / 2.0
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight: .medium)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.text = "1"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sumPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14,weight: .bold)
        label.textAlignment = .center
        label.textColor = .systemGray3
        label.text = "2,321฿"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 18
        layer.shadowColor = UIColor.systemGray2.cgColor
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .init(width: 0, height: 0)
        addButton.addTarget(self, action: #selector(addQuanty), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusQuanty), for: .touchUpInside)
        addSubviews(foodImage,foodNameLabel,descriptionLabel,stackView,sumPrice)
        configureConstraints()
        
    }
    
    @objc private func addQuanty(){
        cartItemViewModel.performQuantity(withAction: "add")
    }
    
    @objc private func minusQuanty(){
        cartItemViewModel.performQuantity(withAction: "minus"){
            if $0 == "delete"{
                self.delegate?.didDeleteCartItem()
            }
        }
    }
    
    
    public func configure(withCart cart:CartItem){
        self.cart = cart
        foodNameLabel.text = cart.menuDetail.foodName
        descriptionLabel.text = cart.menuDetail.description
        quantityLabel.text = String(cart.quantiy)
        foodImage.sd_setImage(with: URL(string:cart.menuDetail.foodImage))
        cartItemViewModel = CartItemViewModel(cartItem: cart)
        bindViewModel()
    }
    
    
    private func bindViewModel(){
        cartItemViewModel.$itemQuantity.sink { [weak self] quantiy in
            guard let self = self else { return }
            self.quantityLabel.text = String(quantiy)
        }.store(in: &cancel)
        cartItemViewModel.$sumPrice.sink { sum in
            self.sumPrice.text = String(sum)
        }.store(in: &cancel)
    }
    
    override func prepareForReuse() {
        foodImage.sd_setImage(with: nil)
        foodNameLabel.text = ""
        descriptionLabel.text = ""
        quantityLabel.text = ""
        cartItemViewModel = nil
    }
    
    private func configureConstraints(){
        
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(quantityLabel)
        stackView.addArrangedSubview(addButton)
        NSLayoutConstraint.activate([
            foodImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            foodImage.widthAnchor.constraint(equalToConstant: 70),
            foodImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            foodImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            foodNameLabel.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 12),
            foodNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            foodNameLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor,constant: -30),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 12),
            descriptionLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor,constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor,constant: -30),
            
            stackView.topAnchor.constraint(equalTo: topAnchor,constant: 18),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            stackView.bottomAnchor.constraint(equalTo: sumPrice.topAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 85),
            
            addButton.widthAnchor.constraint(equalToConstant: 25),
            addButton.heightAnchor.constraint(equalToConstant: 25),
            
            minusButton.widthAnchor.constraint(equalToConstant: 25),
            minusButton.heightAnchor.constraint(equalToConstant: 25),
            
            sumPrice.heightAnchor.constraint(equalToConstant: 20),
            sumPrice.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            sumPrice.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            sumPrice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
