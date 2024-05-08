//
//  CartViewModel.swift
//  GoShop
//
//  Created by MAC on 25/12/2023.
//

import Foundation
import UIKit

class CartViewModel{
    
    //MARK: - Variables
    
    private let api : CartAPI = CartAPI()
    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    var bindResponseToView : (()->()) = {}
    var response:DataClass = DataClass(){
        didSet{
            bindResponseToView()
        }
    }

    //MARK: - Methods

    func numberOfSections() -> Int{
        return 1
    }
    
    func productsNumberInSection(section:Int) -> Int{
        return response.cartItems.count
    }
    
    func getData(){
        api.getFromCart(token:customer_token ?? "nil" ) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            self.response = response.data ?? DataClass()
        }
    }
    
    func postToCart(product_id: Double,vc:UIViewController,operation:@escaping()->()){
        api.postToCart(token: customer_token ?? "nil", product_ID: product_id) { response, error in
            guard let response = response else {return}
            vc.showToast(controller: vc, message: response.message!, seconds: 0.8)
            operation()
        }
    }
    
    func updateCart(itemID: Int,quantity:Int,operation:@escaping(SubCart)->()){
        api.updateCart(token: customer_token ?? "nil", item_id: itemID, quantity: quantity) {
            response, error in
            guard let response = response else {return}
            operation(response.data!)
        }
    }
}
