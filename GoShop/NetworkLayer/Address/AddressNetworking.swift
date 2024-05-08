//
//  AddressNetworking.swift
//  GoShop
//
//  Created by MAC on 27/12/2023.
//


import Foundation
import Alamofire

enum AddressNetworking{
    case getAddresses(token: String)
    case postAddress(token: String,latitude:Double,longitude:Double,city:String,region:String,addressDetails:String,name:String)
    case deleteAddress(token: String,id:Int)
}

extension AddressNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .getAddresses:
            return "https://student.valuxapps.com/api/"
        case .postAddress:
            return "https://student.valuxapps.com/api/"
        case .deleteAddress:
            return "https://student.valuxapps.com/api/"
        }
    }
    
    var endPoint: String {
        switch self{
        case .getAddresses:
            return "addresses"
        case .postAddress:
            return "addresses"
        case .deleteAddress(token: _, id: let id):
            return "addresses/\(id)"
        }
    }
    
    var task: Task {
        switch self{
        case .getAddresses:
            return .requestPlain
        case .postAddress(token: _, latitude: let latitude, longitude: let longitude, city: let city, region: let region, addressDetails: let addressDetails, name: let name):
            return .requestWithParameters(parameters: ["name":name,"city":city,"region":region,"details":addressDetails,"latitude":latitude,"longitude":longitude], encoding: JSONEncoding.default)
        case .deleteAddress(token: _, id: _):
            return .requestPlain
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getAddresses:
            return .get
        case .postAddress:
             return .post
        case .deleteAddress:
            return .delete
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getAddresses(token: let token):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        case .postAddress(token: let token, latitude: _, longitude: _, city: _, region: _, addressDetails: _, name: _):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        case .deleteAddress(token: let token, id: _):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        }
    }

}
