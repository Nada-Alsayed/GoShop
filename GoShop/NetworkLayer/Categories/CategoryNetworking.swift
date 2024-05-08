//
//  CategoryNetworking.swift
//  GoShop
//
//  Created by MAC on 03/01/2024.
//

import Foundation

enum CategoryNetworking{
    case getData(category_id:Int,token:String)
}

extension CategoryNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .getData:
            return "https://student.valuxapps.com/api/"
        }
    }
    
    var endPoint: String {
        switch self{
        case .getData(category_id:let id,token:_):
            return "products?category_id=\(id)"
        }
    }
    
    var task: Task {
        switch self{
        case .getData:
            return .requestPlain
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getData:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getData(category_id:_,token: let token):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        }
    }
}
