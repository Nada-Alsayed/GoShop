//
//  TargetType.swift
//  GoShop
//
//  Created by MAC on 03/12/2023.
//

import Foundation
import Alamofire

enum HTTPMethod : String{
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum Task{
    case requestPlain
    case requestWithParameters(parameters : [String:Any], encoding : ParameterEncoding)
}

protocol TargetType{
    var baseURL : String {get}
    var endPoint : String {get}
    var task : Task {get}
    var httpMethod : HTTPMethod {get}
    var headers : [String:String]? {get}
}
