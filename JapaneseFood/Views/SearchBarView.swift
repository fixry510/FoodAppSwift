//
//  SearchBarView.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import UIKit
import Combine

protocol SearchBarViewDelegate:AnyObject {
    func didChangeSearchMenu(_ text:String)
    func didTapCartButton()
}

class SearchBarView: UIView {
    
    
    var delegate:SearchBarViewDelegate?
    
    private var supscriptions:Set<AnyCancellable> = []
    
    private let badgeNumber: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.frame = .init(x: 30, y: -5, width: 23, height: 23)
        label.layer.cornerRadius = 23.0 / 2.0
        label.layer.masksToBounds = true
        label.text = "1"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.isHidden = true
        return label
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = UIColor(rgb: 0xffFD7C50)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.placeholder = "Search your favorite food"
        
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let image = UIImageView(
            image: UIImage(
                systemName: "magnifyingglass",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 22)
            )
        )
        image.tintColor = UIColor(rgb: 0xffFD7C50)
        image.center = leftView.center
        
        leftView.addSubview(image)
        textField.leftView = leftView
        textField.leftViewMode = .always
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cartButton.addTarget(self, action: #selector(didTapCart), for: .touchUpInside)
        searchTextField.addTarget(self, action: #selector(searchTextChange(_:)), for: .editingChanged)
        configureConstraints()
        bindViewController()
    }
    
    @objc private func didTapCart(){
        delegate?.didTapCartButton()
    }
    
    
    @objc private func searchTextChange(_ textField:UITextField){
        if let text = textField.text {
            delegate?.didChangeSearchMenu(text)
        }
    }
    
    private func configureConstraints(){
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(cartButton,searchTextField)
        cartButton.addSubviews(badgeNumber)
        NSLayoutConstraint.activate([
            cartButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            cartButton.widthAnchor.constraint(equalToConstant: 50),
            cartButton.heightAnchor.constraint(equalToConstant: 50),
            
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            searchTextField.topAnchor.constraint(equalTo: cartButton.bottomAnchor,constant: 15),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private func bindViewController(){
        
        OrderProvider.shared.$carts.sink(receiveValue: { [weak self] carts in
            guard let self = self else { return }
            if carts.count > 0 {
                self.badgeNumber.isHidden = false
                self.badgeNumber.text = "\(OrderProvider.shared.getTotalItemIncart())"
            }else{
                self.badgeNumber.isHidden = true
            }
        }).store(in: &supscriptions)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
