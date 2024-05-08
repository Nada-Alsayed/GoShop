//
//  CartAPI.swift
//  GoShop
//
//  Created by MAC on 23/12/2023.
//

import Foundation
class CartAPI:BaseAPI<CartNetworking>{
    
    func postToCart(token:String ,product_ID : Double,compelition :@escaping (BaseResponse<Product>?,Error?)->()){
        self.fetchData(target: .postToCart(token: token, productID: product_ID), responseClass: BaseResponse<Product>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
          //  print("hhhhh")
            compelition(response, nil)
        }
    }
    
    func getFromCart(token:String,compelition :@escaping (BaseResponse<DataClass>?,Error?)->()){
        self.fetchData(target: .getCart(token: token), responseClass: BaseResponse<DataClass>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
          //  print("hhhhh")
            compelition(response, nil)
        }
    }
    
    func updateCart(token:String ,item_id:Int ,quantity : Int,compelition :@escaping (BaseResponse<SubCart>?,Error?)->()){
        self.fetchData(target: .updateCart(token: token, itemID: item_id, quantity: quantity), responseClass: BaseResponse<SubCart>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
          //  print("hhhhh")
            compelition(response, nil)
        }
    }
}
