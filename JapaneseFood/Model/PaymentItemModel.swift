//
//  PaymentItemModel.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation


class PaymentItemModel {
    var isCheck:Bool
    var paymentName:String
    var logoImage:String
    
    
    init(isCheck: Bool = false, paymentName: String = "", logoImage: String = "") {
        self.isCheck = isCheck
        self.paymentName = paymentName
        self.logoImage = logoImage
    }
    
}
