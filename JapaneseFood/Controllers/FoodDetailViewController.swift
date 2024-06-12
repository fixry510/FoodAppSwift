//
//  FoodDetailViewController.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation

import UIKit
import SDWebImage
import Combine


let s = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"

class FoodDetailViewController: UIViewController {
    
    
    var timer: Timer?
    var imageNo:Int = 0
    var menuDetail:MenuDetail!
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    
    private let miniImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        return imageView
    }()
    
    private let cartIcon:  UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "cart")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let badgeNumber: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.frame = .init(x: 20, y: -8, width: 23, height: 23)
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
    
    
    
    private let descriptionLabel:UITextView = {
        let label = UITextView()
        label.font = .systemFont(ofSize: 16,weight: .regular)
        label.textColor = .secondaryLabel
        label.isUserInteractionEnabled = false
        label.textAlignment = .left
        label.backgroundColor = UIColor(white: 1, alpha: 0)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    
    private let addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = C.cOrange
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationbar()
        bindViewModel()
        
    }
    
    
    @objc private func didTapAddToCartButton(){
        OrderProvider.shared.onAddItemToCart(withMenu: menuDetail)
    }
    
    @objc private func didTapCartIcon(){
        print("didTapCartIcon")
        let vc = CartDetailViewController()
        var stack = navigationController!.viewControllers
        stack.remove(at: stack.count - 1)
        stack.insert(vc, at: stack.count)
        navigationController?.setViewControllers(stack, animated: true)
    }
    
    private func configureUI(){
        view.backgroundColor = .systemBackground
        view.backgroundColor = C.cBackGround
        view.addSubviews(foodImageView,descriptionLabel,addToCartButton)
        cartIcon.addSubview(badgeNumber)
        addToCartButton.addSubviews(cartIcon)
        
        
        addToCartButton.addTarget(self, action: #selector(didTapAddToCartButton), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCartIcon))
        cartIcon.addGestureRecognizer(tap)
        NSLayoutConstraint.activate([
            foodImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foodImageView.topAnchor.constraint(equalTo: view.topAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 500),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            descriptionLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor,constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor),
            
            addToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            addToCartButton.heightAnchor.constraint(equalToConstant: 50),
            addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 10),
            
            cartIcon.heightAnchor.constraint(equalToConstant: 30),
            cartIcon.widthAnchor.constraint(equalToConstant: 30),
            cartIcon.trailingAnchor.constraint(equalTo: addToCartButton.trailingAnchor,constant: -20),
            cartIcon.centerYAnchor.constraint(equalTo: addToCartButton.centerYAnchor)
        ])
    }
    
    public func configure(with menu:MenuDetail){
        menuDetail = menu
        foodImageView.sd_setImage(with: URL(string: menuDetail.foodImage))
        descriptionLabel.text = s
        addToCartButton.setTitle("Add to Cart \(menuDetail.price)฿", for: .normal)
        if let cart: CartItem = OrderProvider.shared.getCartMenu(withId: menu.foodId) {
            badgeNumber.isHidden = false
            badgeNumber.text = String(cart.quantiy)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    @objc func timerFired() {
        let images:[String] = [
            "food-logo2",
            "food-logo3",
            "food-logo4",
            "food-logo5",
            "food-logo1",
        ]
        imageNo = imageNo + 1
        if imageNo > 4  {
            imageNo = 0
        }
        miniImage.image = UIImage(named: images[imageNo])
        
    }
    
    
    private func configureNavigationbar(){
        navigationItem.setHidesBackButton(true, animated: true)
        
        let leftView = UIButton(type: .system)
        leftView.addTarget(self, action: #selector(back), for: .touchUpInside)
        leftView.backgroundColor = .white
        leftView.layer.cornerRadius = 35 / 2
        leftView.layer.masksToBounds = true
        leftView.tintColor = C.cOrange
        leftView.setImage(
            UIImage(
                systemName: "chevron.backward",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 15,weight: .medium)
            ),
            for: .normal
        )
        leftView.frame = .init(x: 0, y: 0, width: 35, height: 35)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: leftView
        )
        //        navigationItem.title = menuDetail.foodName
        
        let titileView = UIView()
        titileView.backgroundColor = C.cOrange
        titileView.layer.cornerRadius = 8
        
        let label = UILabel()
        label.text = menuDetail.foodName
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        titileView.addSubview(label)
        
        navigationItem.titleView = titileView
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: titileView.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: titileView.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: titileView.leadingAnchor,constant: 10),
            label.trailingAnchor.constraint(equalTo: titileView.trailingAnchor,constant: -10),
            label.topAnchor.constraint(greaterThanOrEqualTo: titileView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(lessThanOrEqualTo: titileView.bottomAnchor, constant: -8)
        ])
        
        
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let customView = UIView()
        miniImage.image = UIImage(named: "food-logo1")
        customView.addSubview(miniImage)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: customView
        )
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        miniImage.frame = .init(x: customView.center.x, y: customView.center.y, width: 40, height: 40)
    }
    
    @objc private func back(){
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    private func bindViewModel(){
        OrderProvider.shared.$carts.sink { [weak self] carts in
            print("in sink call")
            guard let self = self else { return }
            if let cart: CartItem = OrderProvider.shared.getCartMenu(withId: self.menuDetail.foodId) {
                badgeNumber.isHidden = false
                badgeNumber.text = String(cart.quantiy)
            }else{
                print("CANNOT FIND CART :(")
            }
        }.store(in: &cancellables)
    }
    
    
    deinit {
        timer?.invalidate()
    }
    
}


extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
