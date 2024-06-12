//
//  CartItem.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation


class CartItem: Identifiable {
    var id = UUID()
    let menuDetail: MenuDetail
    var quantiy: Int
    
    init(id: UUID = UUID(), menuDetail: MenuDetail, quantiy: Int) {
        self.id = id
        self.menuDetail = menuDetail
        self.quantiy = quantiy
    }
    
     public func onChangeQuantity(newQuantity: Int){
        quantiy = newQuantity
    }

}
