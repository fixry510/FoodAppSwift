//
//  SelectPaymentViewController.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import UIKit

class SelectPaymentViewController: UIViewController {
    
    
    let paymentItems:[PaymentItemModel] = [
        PaymentItemModel(isCheck: false,paymentName: "Paypal",logoImage: "paypal"),
        PaymentItemModel(isCheck: false,paymentName: "Visa",logoImage: "visa"),
        PaymentItemModel(isCheck: false,paymentName: "Card",logoImage: "card"),
    ]
    
    let selectPaymentLabel:UILabel = {
        let label = UILabel()
        label.text = "Payment"
        label.textColor = .label
        label.font = .systemFont(ofSize: 17,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let addressView = CustomerAddressView()
    
    let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
        return scrollView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(addressView,selectPaymentLabel,scrollView)
        scrollView.addSubview(stackView)
        for paymentItem in paymentItems {
            let paymentItemView = PaymentItemView()
            paymentItemView.configure(paymentItem: paymentItem)
            paymentItemView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            paymentItemView.delegate = self
            stackView.addArrangedSubview(paymentItemView)
        }
        
        configureConstraints()
        
    }
    
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            addressView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 18),
            addressView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -18),
            addressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            addressView.heightAnchor.constraint(equalToConstant: 80),
            
            selectPaymentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            selectPaymentLabel.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: 20),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: selectPaymentLabel.bottomAnchor,constant: 15),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 18),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -18),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 15),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,constant: -36)
        ])
    
    }
    
}




extension SelectPaymentViewController: PaymentItemViewDelegate{
    
    func didTapPaymentItem(paymentItemView: PaymentItemView) {
        guard let findPayment = self.paymentItems.first(where: { $0.paymentName ==  paymentItemView.paymentNameLabel.text })else{
            return
        }
        for (index,paymentItem) in self.paymentItems.enumerated() {
            if findPayment.paymentName == paymentItem.paymentName { continue }
            guard let paymentView =  self.stackView.arrangedSubviews[index] as? PaymentItemView else {
                return
            }
            paymentItem.isCheck = false
            paymentView.configure(paymentItem: paymentItem)
        }
      
        findPayment.isCheck = !findPayment.isCheck
        paymentItemView.configure(paymentItem: findPayment)
        
    }
    
    
    
}
