//
//  CategoryCellCollectionViewCell.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import UIKit
import SDWebImage

class CategoryCellCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCellCollectionViewCell"
    
    private let imageView:UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFit
       imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(imageView,label)
        configureConstraints()
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: -3),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -3),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 55),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 5),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    public func configure(with category:Category){
        label.text = category.catgoryName
        imageView.sd_setImage(with: URL(string: category.imageCatagory))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}

