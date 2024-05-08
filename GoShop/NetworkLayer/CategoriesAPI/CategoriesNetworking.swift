//
//  CategoriesNetworking.swift
//  GoShop
//
//  Created by MAC on 18/12/2023.
//

import Foundation
enum CategoriesNetworking{
    case getData
}

extension CategoriesNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .getData:
           return "https://student.valuxapps.com/api/"
        }
    }
    
    var endPoint: String {
        switch self{
        case .getData:
            return "categories"
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
        case .getData:
            return ["lang":"en"]
        }
    }
}
