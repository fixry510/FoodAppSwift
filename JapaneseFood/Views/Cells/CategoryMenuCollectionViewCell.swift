//
//  CategoryMenuCollectionViewCell.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import UIKit


class CategoryMenuCollectionViewCell: UICollectionViewCell {
    
    static let identifier:String = "CategoryMenuCollectionViewCell"
    
//    var delegate:CategoryMenuCollectionViewCellDelegate?
    
     let menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let menuName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
     let menuPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    
    private var menu: MenuDetail!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 15 + 8
        clipsToBounds = true
        addSubviews(
            menuImageView,
            menuName,
            menuPrice
        )
        configureConstraints()
    }
    
    public func configureConstraints(){
        NSLayoutConstraint.activate([
            menuImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            menuImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            menuImageView.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            menuImageView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -60),
            
            menuName.topAnchor.constraint(equalTo: menuImageView.bottomAnchor, constant: 8),
            menuName.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            menuName.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuName.heightAnchor.constraint(equalToConstant: 20),
            
            menuPrice.topAnchor.constraint(equalTo: menuName.bottomAnchor,constant: 5),
            menuPrice.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            menuPrice.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuPrice.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    public func configure(withMenu menuDetail:MenuDetail){
        menu = menuDetail
        menuName.text = menu.foodName
        menuPrice.text = String(menuDetail.price)
        menuImageView.sd_setImage(with: URL(string: menuDetail.foodImage))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
