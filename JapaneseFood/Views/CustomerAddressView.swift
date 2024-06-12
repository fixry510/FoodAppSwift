//
//  CustomerAddressView.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import UIKit

class CustomerAddressView: UIView {
    
    
    let pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "location-pin")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let addressTitleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight: .medium)
        label.textColor = .label
        label.text = "Home"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressDetailLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15,weight: .regular)
        label.textColor = .systemGray2
        label.text = "711-2880 Nulla St. Mankato Mississippi 96522 (257) 563-7401"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(pinImageView,addressTitleLabel,addressDetailLabel)
        configureLayer()
        configureConstraints()
    }
    
    private func configureConstraints(){
        
        NSLayoutConstraint.activate([
            pinImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            pinImageView.widthAnchor.constraint(equalToConstant: 35),
            pinImageView.topAnchor.constraint(equalTo: topAnchor,constant: 15),
            pinImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -15),
            
            addressTitleLabel.leadingAnchor.constraint(equalTo: pinImageView.trailingAnchor, constant: 15),
            addressTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            
            addressDetailLabel.leadingAnchor.constraint(equalTo: pinImageView.trailingAnchor, constant: 15),
            addressDetailLabel.topAnchor.constraint(equalTo: addressTitleLabel.bottomAnchor, constant: 5),
            addressDetailLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            
        ])
    }
    
    private func configureLayer(){
        layer.cornerRadius = 18
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .init(width: -1, height: -1)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
