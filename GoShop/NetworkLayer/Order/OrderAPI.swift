//
//  OrderAPI.swift
//  GoShop
//
//  Created by MAC on 27/12/2023.
//

import Foundation

class OrderAPI :BaseAPI<OrderNetworking>{
    
    func getOrders(token:String, compelition :@escaping (BaseResponse<MyData<[Datum]>>?,Error?)->()){
        self.fetchData(target: .getOrders(token: token), responseClass: BaseResponse<MyData<[Datum]>>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
            print("Orders Feched")
            compelition(response, nil)
        }
    }
    
    func getOrderDetails(token:String,id:Int, compelition :@escaping (BaseResponse<OrderDetails>?,Error?)->()){
        self.fetchData(target: .getOrderDetails(token: token, id: id), responseClass: BaseResponse<OrderDetails>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
            print("Order Feched")
            compelition(response, nil)
        }
    }
    
    func postOrder(token: String, addressID:Int, payMethod:Int, points:Bool, promoCode:Int, compelition :@escaping (BaseResponse<Order>?,Error?)->()){
        self.fetchData(target: .postOrder(token: token, addressID: addressID, payMethod: payMethod, points: points, promoCode: promoCode), responseClass: BaseResponse<Order>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
            compelition(response, nil)
        }
    }
    
    func cancelOrder(token: String, orderID:Int, compelition:@escaping (BaseResponse<Order>?,Error?)->()){
        self.fetchData(target: .cancelOrder(token: token, orderId: orderID) , responseClass: BaseResponse<Order>.self)  { response, err in
            guard let response = response else { return  compelition(nil,err) }
            print("Order Canceled")
            compelition(response, nil)
        }
    }
}
