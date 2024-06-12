//
//  OrderProvider.swift
//  JapaneseFood
//
//  Created by Pin Sukjaroen on 13/6/2567 BE.
//

import Foundation
import Combine


final class OrderProvider: ObservableObject {
    
    
    static let shared:OrderProvider = OrderProvider()

    @Published var carts:[CartItem] = []
    
    
    
    public func onAddItemToCart(withMenu menu:MenuDetail){
        if let findMenuInCart: CartItem = carts.first(where: {$0.menuDetail.foodId == menu.foodId}) {
            addQuantity(cartId: findMenuInCart.id.uuidString)
        }else{
            carts.append(.init(menuDetail: menu, quantiy: 1))
        }
        carts = carts
    }
    
    
    public func addQuantity(cartId: String){
        guard let cart = getCartByCardId(withId: cartId) else {
            return
        }
        cart.quantiy += 1
        carts = carts
    }
    
    public func minusQuantity(cartId: String){
        guard let cart = getCartByCardId(withId: cartId) else {
            return
        }
        cart.quantiy -= 1
        carts = carts
    }
    
    public func deleteCart(foodId: String){
        guard let index = carts.firstIndex(where: {$0.menuDetail.foodId == foodId})else {
            return
        }
        carts.remove(at: index)
    }
    
    
    public func getCartMenu(withId id:String) -> CartItem? {
        if let findMenuInCart: CartItem = carts.first(where: {$0.menuDetail.foodId == id}) {
            return findMenuInCart
        }
        return nil
    }
    
    public func getCartByCardId(withId id:String) -> CartItem? {
        if let findMenuInCart: CartItem = carts.first(where: {$0.id.uuidString == id}) {
            return findMenuInCart
        }
        return nil
    }
    
    
    public func getTotalItemIncart() -> Int{
        var totalItemCart: Int = 0
        for cart in carts {
            totalItemCart += cart.quantiy
        }
        return totalItemCart
    }
}
