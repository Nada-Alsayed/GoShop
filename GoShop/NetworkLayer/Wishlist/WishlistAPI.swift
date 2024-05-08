//
//  WishlistAPI.swift
//  GoShop
//
//  Created by MAC on 23/12/2023.
//

import Foundation

class WishlistAPI:BaseAPI<WishlistNetworking>{
    
    func postToWishlist(token:String ,product_ID : Double,compelition :@escaping (BaseResponse<Product>?,Error?)->()){
        self.fetchData(target: .postToWishlist(token: token, productID: product_ID), responseClass: BaseResponse<Product>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
          //  print("hhhhh")
            compelition(response, nil)
        }
    }
    
    func getFromWishlist(token:String,compelition :@escaping (BaseResponse<MyData<[Favourite]>>?,Error?)->()){
        self.fetchData(target: .getWishlist(token: token), responseClass: BaseResponse<MyData<[Favourite]>>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
          //  print("hhhhh")
            compelition(response, nil)
        }
    }
}
