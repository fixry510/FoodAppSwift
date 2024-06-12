//
//  CartItemViewModel.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import Combine

class CartItemViewModel:ObservableObject {
    let cartItem:CartItem
    
    @Published var itemQuantity:Int
    
    @Published var sumPrice:Double
    
    
    init(cartItem:CartItem) {
        self.cartItem = cartItem
        self.itemQuantity = self.cartItem.quantiy
        self.sumPrice = self.cartItem.menuDetail.price * Double(cartItem.quantiy)
    }
    
    
    public func performQuantity(withAction action:String,completion:((_ status:String) -> Void)? = nil ){
        guard let cart  = OrderProvider.shared.getCartByCardId(withId: cartItem.id.uuidString) else {
            return
        }
        if action == "add"{
            OrderProvider.shared.addQuantity(cartId: cart.id.uuidString)
            completion?("success")
        }else{
            OrderProvider.shared.minusQuantity(cartId: cart.id.uuidString)
        }
        itemQuantity = cart.quantiy
        if(itemQuantity == 0){
            deleteCartItem()
            completion?("delete")
            return
        }
        sumPrice = cartItem.menuDetail.price * Double(cart.quantiy)
        completion?("success")
    }
    
    
    public func deleteCartItem(){
        print("Delete cart")
        OrderProvider.shared.deleteCart(foodId: cartItem.menuDetail.foodId)
    }
    
    
    
    
    
    
    
}
