//
//  WishlistNetworking.swift
//  GoShop
//
//  Created by MAC on 23/12/2023.
//

import Foundation
import Alamofire

enum WishlistNetworking{
    case postToWishlist(token: String,productID: Double)
    case getWishlist(token: String)
}

extension WishlistNetworking : TargetType{
    
    var baseURL: String {
        switch self{
        case .postToWishlist:
            return "https://student.valuxapps.com/api/"
            
        case .getWishlist:
            return "https://student.valuxapps.com/api/"
        }
    }
    var endPoint: String {
        switch self{
        case .postToWishlist:
            return "favorites"
            
        case .getWishlist:
            return "favorites"

        }
    }
    
    var task: Task {
        switch self{
        case .postToWishlist(token: _,productID: let id):
            return .requestWithParameters(parameters: ["product_id":id], encoding: JSONEncoding.default)
        case .getWishlist:
            return .requestPlain
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .postToWishlist:
            return .post
            
        case .getWishlist:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .postToWishlist(token: let token,productID: _):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        case .getWishlist(token: let token):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        }
    }
}
