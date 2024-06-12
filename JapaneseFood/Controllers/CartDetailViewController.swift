//
//  CartDetailViewController.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import UIKit
import Combine


class CartDetailViewController: UIViewController {
    
    
   
    
    private let miniImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var isShowCartItem = true
    
    
    private var cartViewController: CartSummaryItemsViewController = CartSummaryItemsViewController()
    private var selectPaymentViewController:SelectPaymentViewController = SelectPaymentViewController()
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let summaryCartView: CartSummaryView = CartSummaryView()
    
    
    var timer: Timer?
    var imageNo:Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart Detail"
        view.backgroundColor = .white
        summaryCartView.delegate = self
        configureNavigationbar()
        configureConstraints()
    }
    
    


    
    private func configureConstraints(){
        addChild(cartViewController)
        cartViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews(cartViewController.view,summaryCartView)
        
        NSLayoutConstraint.activate([
            cartViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            cartViewController.view.bottomAnchor.constraint(equalTo: summaryCartView.topAnchor,constant: -10),
            
            
            summaryCartView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            summaryCartView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            summaryCartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            summaryCartView.heightAnchor.constraint(equalToConstant: 170),
        ])
        
        cartViewController.didMove(toParent: self)
    }
    
    
    private func configureNavigationbar(){
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
    
    
    @objc private func back(){
        if !isShowCartItem{
            switchDisplay()
        }else{
            navigationController?.popViewController(animated: true)
        }
    }

}



extension CartDetailViewController: CartSummaryViewDelegate{
    
    func didTapContinue() {
        switchDisplay()
    }
    
    
    private func switchDisplay(){
        let fromViewController = isShowCartItem ? cartViewController : selectPaymentViewController
        let toViewController = isShowCartItem ? selectPaymentViewController : cartViewController
        addChild(toViewController)
        toViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toViewController.view)
        NSLayoutConstraint.activate([
            toViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            toViewController.view.bottomAnchor.constraint(equalTo: summaryCartView.topAnchor,constant: -10),
        ])
        if isShowCartItem {
            UIView.transition(with: summaryCartView.submitButton, duration: 0.5) {
                self.title = "Checkout"
                self.summaryCartView.submitButton.setTitle("SUBMIT", for: .normal)
            }
           
        }else{
            UIView.transition(with: summaryCartView.submitButton, duration: 0.5) {
                self.title = "CartDetail"
                self.summaryCartView.submitButton.setTitle("CONTINUE", for: .normal)
            }
        }
        transition(
            from: fromViewController,
            to: toViewController,
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: { completed in
                fromViewController.willMove(toParent: nil)
                fromViewController.view.removeFromSuperview()
                fromViewController.removeFromParent()
                toViewController.didMove(toParent: self)
                self.isShowCartItem.toggle()
    
            }
        )
    }
}







