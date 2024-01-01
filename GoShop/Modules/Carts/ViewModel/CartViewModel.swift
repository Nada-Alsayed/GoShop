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
    var bindProductsToView : (()->()) = {}
    var products: [Favourite] = []{
        didSet{
            bindProductsToView()
        }
    }

    //MARK: - Methods

    func numberOfSections() -> Int{
        return 1
    }
    
    func productsNumberInSection(section:Int) -> Int{
        return products.count
    }
    
    func getData(){
        api.getFromCart(token:customer_token ?? "nil" ) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            self.products = response.data?.cartItems ?? []
        }
    }
    
    func postToCart(product_id: Double,vc:UIViewController,operation:@escaping()->()){
        api.postToCart(token: customer_token ?? "nil", product_ID: product_id) { response, error in
            guard let response = response else {return}
            print(response.message!)
            vc.showToast(controller: vc, message: response.message!, seconds: 0.8)
            operation()
        }
    }
}
