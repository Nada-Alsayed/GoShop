//
//  OrderDetailsExtension.swift
//  GoShop
//
//  Created by MAC on 31/12/2023.
//

import Foundation

class OrderDetailsViewModel{
    
    var api = OrderAPI()
    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    var bindOrderToView : (()->()) = {}
    var orderDetails = OrderDetails(){
        didSet{
            bindOrderToView()
        }
    }
    
    func getData(product_id: Int){
        api.getOrderDetails(token: customer_token ?? "", id: product_id) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
           // print("hhhh\(response.data)")
            self.orderDetails = response.data ?? OrderDetails()
        }
    }
    
    func cancelOrder(orderId: Int){
        api.cancelOrder(token: customer_token ?? "", orderID: orderId) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
        }
    }
    
    func numberOfSections() -> Int{
        return 1
    }
    
    func numberOfProducts(section:Int) -> Int{
        return orderDetails.products.count
    }
    
}
