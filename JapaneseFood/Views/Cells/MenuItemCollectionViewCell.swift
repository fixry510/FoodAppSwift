//
//  MenuItemCollectionViewCell.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import SDWebImage

class MenuItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier:String = "MenuItemCollectionViewCell"
    
    public let menuImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let menuNameLabel:UILabel = {
       let label = UILabel()
       label.font = .systemFont(ofSize: 18,weight: .bold)
        label.numberOfLines = 1
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private let priceLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15,weight: .regular)
        label.textColor = .white
        label.backgroundColor =  UIColor(rgb: 0xffFD7C50)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starRate:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 15))
        imageView.tintColor = UIColor(rgb: 0xffFD7C50)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let rateLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15,weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15,weight: .regular)
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(
            menuImageView,
            menuNameLabel,
            priceLabel,
            starRate,
            rateLabel,
            descriptionLabel
        )
        
        let testView = UIView()
        testView.frame = .init(x: 0, y: bounds.maxY + 12.5, width: frame.width, height: 1)
        testView.backgroundColor = UIColor(rgb: 0xffDADADA)
        addSubview(testView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with menuDetail:MenuDetail){
        menuImageView.sd_setImage(with: URL(string: menuDetail.foodImage))
        menuNameLabel.text = menuDetail.foodName
        priceLabel.text = "  \(menuDetail.price)฿  "
        rateLabel.text = "\(menuDetail.foodScore)"
        descriptionLabel.text = menuDetail.description
    }
    
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            menuImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuImageView.topAnchor.constraint(equalTo: topAnchor),
            menuImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            menuImageView.widthAnchor.constraint(equalToConstant: 130),
            
            menuNameLabel.leadingAnchor.constraint(equalTo: menuImageView.trailingAnchor,constant: 8),
            menuNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuNameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            menuNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: topAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 30),
            priceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            starRate.leadingAnchor.constraint(equalTo: menuImageView.trailingAnchor,constant: 8),
            starRate.topAnchor.constraint(equalTo: menuNameLabel.bottomAnchor,constant: 5),
            starRate.widthAnchor.constraint(equalToConstant: 20),
            starRate.heightAnchor.constraint(equalToConstant: 20),
          
            
            rateLabel.leadingAnchor.constraint(equalTo: starRate.trailingAnchor,constant: 5),
            rateLabel.topAnchor.constraint(equalTo: menuNameLabel.bottomAnchor,constant: 5),
            rateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            rateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: menuImageView.trailingAnchor,constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: starRate.bottomAnchor,constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}
