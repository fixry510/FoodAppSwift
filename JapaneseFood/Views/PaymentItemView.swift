//
//  PaymentItemView.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import UIKit

protocol PaymentItemViewDelegate:AnyObject {
    func didTapPaymentItem(paymentItemView:PaymentItemView)
}

class PaymentItemView: UIView {
    
    
    var delegate:PaymentItemViewDelegate?
    
    let radioCheck:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25.0 / 2.0
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.systemGray3.cgColor
        return view
    }()
    
    let checkSelf:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark",withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let paymentNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text  = "Paypal"
        return label
    }()
    
    let paymentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "paypal")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        configureLayer()
        addSubviews(radioCheck,paymentNameLabel,paymentImageView)
        configureConstraints()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func didTap(){
        delegate?.didTapPaymentItem(paymentItemView: self)
    }
    
    private func configureLayer(){
        layer.cornerRadius = 18
        layer.shadowColor = UIColor.systemGray3.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .init(width: -1, height: -1)
    }
    
    public func configure(paymentItem:PaymentItemModel){
        paymentNameLabel.text = paymentItem.paymentName
        paymentImageView.image = UIImage(named: paymentItem.logoImage)
        setCheckRadio(checked:paymentItem.isCheck)
    }
    
    private func setCheckRadio(checked:Bool){
        if(checked){
            UIView.transition(with: radioCheck, duration: 0.1) {
                self.radioCheck.addSubview(self.checkSelf)
                self.radioCheck.layer.borderWidth = 0
                self.radioCheck.backgroundColor = .systemGreen
                NSLayoutConstraint.activate([
                    self.checkSelf.leadingAnchor.constraint(equalTo: self.radioCheck.leadingAnchor,constant: 4),
                    self.checkSelf.trailingAnchor.constraint(equalTo: self.radioCheck.trailingAnchor,constant: -4),
                    self.checkSelf.topAnchor.constraint(equalTo: self.radioCheck.topAnchor,constant: 4),
                    self.checkSelf.bottomAnchor.constraint(equalTo: self.radioCheck.bottomAnchor,constant: -4)
                ])
            }
        }else{
            UIView.transition(with: radioCheck, duration: 0.1) {
                self.checkSelf.removeFromSuperview()
                self.radioCheck.layer.borderWidth = 0.5
                self.radioCheck.backgroundColor = .white
                self.radioCheck.layer.borderColor = UIColor.systemGray3.cgColor
            }
        }
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            
            radioCheck.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 18),
            radioCheck.widthAnchor.constraint(equalToConstant: 25),
            radioCheck.heightAnchor.constraint(equalToConstant: 25),
            radioCheck.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            paymentNameLabel.leadingAnchor.constraint(equalTo: radioCheck.trailingAnchor,constant: 20),
            paymentNameLabel.trailingAnchor.constraint(equalTo: paymentImageView.trailingAnchor),
            paymentNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            paymentImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            paymentImageView.widthAnchor.constraint(equalToConstant: 30),
            paymentImageView.heightAnchor.constraint(equalToConstant: 30),
            paymentImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
