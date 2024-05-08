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
    case updateCart(token: String,itemID: Int,quantity:Int)
}

extension CartNetworking : TargetType{
    
    var baseURL: String {
        switch self{
        case .postToCart:
            return "https://student.valuxapps.com/api/"
        case .getCart:
            return "https://student.valuxapps.com/api/"
        case .updateCart:
            return "https://student.valuxapps.com/api/"
        }
    }
    var endPoint: String {
        switch self{
        case .postToCart:
            return "carts"
        case .getCart:
            return "carts"
        case .updateCart(token: _, itemID: let itemID, quantity: _):
            return "carts/\(itemID)"
        }
    }
    
    var task: Task {
        switch self{
        case .postToCart(token: _,productID: let id):
            return .requestWithParameters(parameters: ["product_id":id], encoding: JSONEncoding.default)
        case .getCart:
            return .requestPlain
        case .updateCart(token: _, itemID: _, quantity: let quantity):
            return .requestWithParameters(parameters: ["quantity":quantity], encoding: JSONEncoding.default)
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .postToCart:
            return .post
        case .getCart:
            return .get
        case .updateCart:
            return .put
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
        case .updateCart(token: let token, itemID: _, quantity: _):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        }
    }
}
