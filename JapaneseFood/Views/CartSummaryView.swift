//
//  CartSummaryView.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import Combine
import UIKit

protocol CartSummaryViewDelegate:AnyObject {
    func didTapContinue()
}

class CartSummaryView: UIView {

    private var cancellables: Set<AnyCancellable> = []
    
    public var delegate:CartSummaryViewDelegate?
    
    private let subTotalLeadingLabel:UILabel = {
       let label = UILabel()
        label.text = "Subtotal"
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 14,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTotalTralingLabel:UILabel = {
       let label = UILabel()
        label.text = "0"
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 14,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let shipingLeadingLabel:UILabel = {
       let label = UILabel()
        label.text = "Shiping Const"
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 14,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let shipingTralingLabel:UILabel = {
       let label = UILabel()
        label.text = "0"
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 14,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let grandTotalLeadingLabel:UILabel = {
       let label = UILabel()
        label.text = "Total"
        label.textColor = .label
        label.font = .systemFont(ofSize: 18,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let grandTotalTralingLabel:UILabel = {
        let label = UILabel()
         label.text = "0"
         label.textColor = .label
         label.font = .systemFont(ofSize: 18,weight: .medium)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    

    private let saparateView:UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
    
    public let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CONTINUE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = C.cOrange
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        submitButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        addSubviews(
            subTotalLeadingLabel,
            subTotalTralingLabel,
            shipingLeadingLabel,
            shipingTralingLabel,
            saparateView,
            grandTotalLeadingLabel,
            grandTotalTralingLabel,
            submitButton
        )
        configureConstraints()
        bindViewModel()
    }
    
    
    @objc private func didTapButton(){
        delegate?.didTapContinue()
    }
    
    private func bindViewModel(){
        OrderProvider.shared.$carts.sink { [weak self] carts in
            guard let self = self else { return }
            var sumPrice:Double = 0
            carts.forEach { cart in
                sumPrice += Double(cart.quantiy) * cart.menuDetail.price
            }
            subTotalTralingLabel.text = UtilsMethod.formatPrice(sumPrice)
            shipingTralingLabel.text = UtilsMethod.formatPrice(25)
            grandTotalTralingLabel.text = UtilsMethod.formatPrice(sumPrice + 25)
            
        }.store(in: &cancellables)
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            subTotalLeadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            subTotalLeadingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            
            subTotalTralingLabel.centerYAnchor.constraint(equalTo: subTotalLeadingLabel.centerYAnchor),
            subTotalTralingLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            
            shipingLeadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            shipingLeadingLabel.topAnchor.constraint(equalTo: subTotalLeadingLabel.bottomAnchor, constant: 5),
            
            shipingTralingLabel.centerYAnchor.constraint(equalTo: shipingLeadingLabel.centerYAnchor),
            shipingTralingLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            
            saparateView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            saparateView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            saparateView.topAnchor.constraint(equalTo: shipingLeadingLabel.bottomAnchor, constant: 8),
            saparateView.heightAnchor.constraint(equalToConstant: 1),
            
            grandTotalLeadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            grandTotalLeadingLabel.topAnchor.constraint(equalTo: saparateView.bottomAnchor, constant: 8),
            
            grandTotalTralingLabel.centerYAnchor.constraint(equalTo: grandTotalLeadingLabel.centerYAnchor),
            grandTotalTralingLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            submitButton.heightAnchor.constraint(equalToConstant: 45),
            submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -5),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
