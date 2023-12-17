//
//  MoviesNetworking.swift
//  GoShop
//
//  Created by MAC on 03/12/2023.
//

import Foundation

enum MoviesNetworking{
    case getUsers
}

extension MoviesNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .getUsers:
           return ""
        }
    }
    
    var endPoint: String {
        switch self{
        case .getUsers:
            return ""
        }
    }
    
    var task: Task {
        switch self{
        case .getUsers:
            return .requestPlain
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getUsers:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getUsers:
            // return ["Authorization" : "Barear Auth"]
            return [:]
        }
    }
}
