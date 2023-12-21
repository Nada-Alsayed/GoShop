//
//  MoviesNetworking.swift
//  GoShop
//
//  Created by MAC on 03/12/2023.
//

import Foundation
import Alamofire

enum UsersNetworking{
    case postUser(name: String,phone: String,email: String,password: String, image : String)
}

extension UsersNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .postUser:
           return "https://student.valuxapps.com/api/"
        }
    }
    
    var endPoint: String {
        switch self{
        case .postUser:
            return "register"
        }
    }
    
    var task: Task {
        switch self{
        case .postUser(let name, let phone ,let email , let password , let image):
            return .requestWithParameters(parameters: ["name":name ,"phone":phone,"email":email,"password":password,"image" : image], encoding: JSONEncoding.default)
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .postUser:
            return .post
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .postUser:
            return ["lang":"en"]
        }
    }
}
