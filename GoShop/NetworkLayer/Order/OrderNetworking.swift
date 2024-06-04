//
//  OrderNetworking.swift
//  GoShop
//
//  Created by MAC on 27/12/2023.
//

import Foundation
import Alamofire

//"address_id": 3833,
//    "payment_method": 1,
//    "use_points": false,
//    "promo_code_id": 0

enum OrderNetworking{
    case getOrders(token: String)
    case postOrder(token: String, addressID:Int, payMethod:Int, points:Bool, promoCode:Int)
    case getOrderDetails(token: String,id:Int)
    case cancelOrder(token: String , orderId:Int)
}

extension OrderNetworking : TargetType{
    var baseURL: String {
        switch self{
        case .getOrders:
            return "https://student.valuxapps.com/api/"
        case .postOrder:
            return "https://student.valuxapps.com/api/"
        case .getOrderDetails:
            return "https://student.valuxapps.com/api/"
        case .cancelOrder(token: let token, orderId: let orderId):
            return "https://student.valuxapps.com/api/"
        }
    }
    
    var endPoint: String {
        switch self{
        case .getOrders:
            return "orders"
        case .postOrder:
            return "orders"
        case .getOrderDetails(token: _, id: let id):
            return "orders/\(id)"
        case .cancelOrder(token: _, orderId: let orderId):
            return "orders/\(orderId)/cancel"
        }
    }
    
    var task: Task {
        switch self{
        case .getOrders(token: _):
            return .requestPlain
        case .postOrder(token: _, addressID: let addressID, payMethod: let payMethod, points: let points, promoCode: let promoCode):
            return .requestWithParameters(parameters: ["address_id":addressID, "payment_method":payMethod , "use_points":points, "promo_code_id":promoCode], encoding: JSONEncoding.default)
        case .getOrderDetails(token: _, id: _):
            return .requestPlain
        case .cancelOrder(token: _, orderId: _):
            return .requestPlain
        }

    }
    
    var httpMethod: HTTPMethod {
        switch self{
        case .getOrders:
            return .get
        case .postOrder:
            return .post
        case .getOrderDetails:
            return .get
        case .cancelOrder(token: _, orderId: _):
            return .get
        }

    }
    
    var headers: [String : String]? {
        switch self{case .getOrders(token: let token):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        case .postOrder(token: let token, addressID: _, payMethod: _, points: _, promoCode: _):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        case .getOrderDetails(token: let token, id: _):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        case .cancelOrder(token: let token, orderId: _):
            return ["lang":"en"
                    ,"Content-Type":"application/json"
                    ,"Authorization":token ]
        }
    }
}
