//
//  DetailsViewModel.swift
//  GoShop
//
//  Created by MAC on 22/12/2023.
//

import Foundation
import UIKit

class DetailsViewModel{
    
    //MARK: -Variables

    let apiWishList : WishlistAPI = WishlistAPI()
    let apiProduct :ProductAPI = ProductAPI()
    let apiCart : CartAPI = CartAPI()
    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    var bindProductToView : (()->()) = {}
    var product: Product = Product(){
        didSet{
            bindProductToView()
        }
    }
    var delegate : ResponseMessage?
    
    //MARK: -Methods
    
    func getData(product_id:Double){
        apiProduct.getProductDetails(token: customer_token ?? "", id: product_id){ [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            self.product = response.data ?? Product()
           // print("product details:\(self.product) ")
        }
    }
    
    func postToWishlist(product_id: Double,vc:UIViewController){
        apiWishList.postToWishlist(token: customer_token ?? "nil", product_ID: product_id) { response, error in
        //    guard let self = self else{return}
          //  print("llll")
            guard let response = response else {return}
         //   print("llll")
            print(response.message!)
            self.delegate?.responsIsDone(message: response.message!)
            //vc.showToast(controller: vc, message: response.message!, seconds: 0.8)
        }
    }
    
    func postToCart(product_id: Double,vc:UIViewController,operation:@escaping()->()){
        apiCart.postToCart(token: customer_token ?? "nil", product_ID: product_id) { response, error in
        //    guard let self = self else{return}
         //   print("llll")
            guard let response = response else {return}
        //    print("llll")
            print(response.message!)

            vc.showToast(controller: vc, message: response.message!, seconds: 0.8)
            operation()
        }
    }
}
