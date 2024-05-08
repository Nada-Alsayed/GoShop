//
//  ProductNetworking.swift
//  GoShop
//
//  Created by MAC on 24/12/2023.
//

import Foundation

enum ProductNetworking{
    case getProductByID(token: String,productID: Double)
}

extension ProductNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .getProductByID:
            return "https://student.valuxapps.com/api/"
        }
    }
    
    var endPoint: String {
        switch self{
        case .getProductByID(token: let token,productID:let id):
            return "products/\(id)"
        }
    }
    
    var task: Task {
        switch self{
        case .getProductByID:
            return .requestPlain
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getProductByID:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getProductByID(token: let token,productID:let id):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        }
    }

}
