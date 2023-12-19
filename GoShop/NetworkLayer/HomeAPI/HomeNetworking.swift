//
//  HomeNetworking.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation

enum HomeNetworking{
    case getData
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
        case .getData:
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":"b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV"]
        }
    }
}
