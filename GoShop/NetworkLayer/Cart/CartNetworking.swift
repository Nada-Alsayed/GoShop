//
//  CartNetworking.swift
//  GoShop
//
//  Created by MAC on 23/12/2023.
//

import Foundation
import Alamofire

enum CartNetworking{
    case postToCart(token: String,productID: Double)
    case getCart(token: String)
}

extension CartNetworking : TargetType{
    
    var baseURL: String {
        switch self{
        case .postToCart:
            return "https://student.valuxapps.com/api/"
            
        case .getCart:
            return "https://student.valuxapps.com/api/"
        }
    }
    var endPoint: String {
        switch self{
        case .postToCart:
            return "carts"
            
        case .getCart:
            return "carts"
        }
    }
    
    var task: Task {
        switch self{
        case .postToCart(token: _,productID: let id):
            return .requestWithParameters(parameters: ["product_id":id], encoding: JSONEncoding.default)
        case .getCart:
            return .requestPlain
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .postToCart:
            return .post
            
        case .getCart:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .postToCart(token: let token,productID: _):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        case .getCart(token: let token):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        }
    }
}
