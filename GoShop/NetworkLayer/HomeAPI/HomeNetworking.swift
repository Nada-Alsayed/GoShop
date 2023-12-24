//
//  HomeNetworking.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation

enum HomeNetworking{
    case getData(token:String)
}

extension HomeNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .getData:
           return "https://student.valuxapps.com/api/"
        }
    }
    
    var endPoint: String {
        switch self{
        case .getData:
            return "home"
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
        case .getData(token: let token):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        }
    }
}
