//
//  FavoritesViewModel.swift
//  GoShop
//
//  Created by MAC on 24/12/2023.
//

import Foundation
import UIKit

class FavoritesViewModel{
    
    //MARK: - Variables
    
    private let api : WishlistAPI = WishlistAPI()
    private let apiCart : CartAPI = CartAPI()
    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    var bindProductsToView : (()->()) = {}
    var bindCartItemsToView : (()->()) = {}
    var products: [Favourite] = []
    var cartItems: [Favourite] = []
    
    //MARK: - Methods

    func numberOfSections() -> Int{
        return 1
    }
    
    func productsNumberInSection(section:Int) -> Int{
        return products.count
    }
    
    func getData(){
        api.getFromWishlist(token:customer_token ?? "nil" ) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            self.products = response.data?.data ?? []
            self.getDataFromCart()
        }
    }
    
    func getDataFromCart(){
        apiCart.getFromCart(token:customer_token ?? "nil" ) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            self.cartItems = response.data?.cartItems ?? []
           // print("product: \(self.products)")
           // print("cart: \(self.cartItems)")
            
            for i in 0..<self.products.count {
                var isInCart = false  // check if is in cart
                for j in 0..<self.cartItems.count {
                    if self.products[i].product.id == self.cartItems[j].product.id {
                        isInCart = true
                        break  // Exit the inner loop once a match is found
                    }
                }
                self.products[i].product.inCart = isInCart
               // print("ww\(self.products[i].product.inCart)")
            }
           // print("ee\(self.products[0].product.inCart)")
           // print("ee\(self.products[1].product.inCart)")
            self.bindProductsToView()
        }
    }
    
    func postToCart(product_id: Double,vc:UIViewController,operation:@escaping()->()){
        apiCart.postToCart(token: customer_token ?? "nil", product_ID: product_id) { response, error in
            guard let response = response else {return}
            print(response.message!)
            vc.showToast(controller: vc, message: response.message!, seconds: 0.8)
            operation()
        }
    }
    
    func postToWishlist(product_id: Double,operation:@escaping()->()){
        api.postToWishlist(token: customer_token ?? "nil", product_ID: product_id) { response, error in
            guard let response = response else {return}
            print(response.message!)
            operation()
        }
    }
}
