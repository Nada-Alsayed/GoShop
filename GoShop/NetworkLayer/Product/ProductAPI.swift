//
//  ProductAPI.swift
//  GoShop
//
//  Created by MAC on 24/12/2023.
//

import Foundation

class ProductAPI:BaseAPI<ProductNetworking>{
    func getProductDetails(token:String,id : Double,compelition :@escaping (BaseResponse<Product>?,Error?)->()){
        self.fetchData(target: .getProductByID(token: token, productID: id), responseClass: BaseResponse<Product>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
          //  print("hhhhh")
            compelition(response, nil)
        }
    }
}
