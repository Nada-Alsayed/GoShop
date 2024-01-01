//
//  OrdersViewModel.swift
//  GoShop
//
//  Created by MAC on 30/12/2023.
//

import Foundation

class OrderViewModel{
    
    let apiOrder = OrderAPI()
    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    var bindOrdersToView : (()->()) = {}
    var orders: [Datum] = []
    var newOrders : [Datum] = []
    var canceledOrders : [Datum] = []{
        didSet{
            bindOrdersToView()
        }
    }
    
    
    func getData(){
        apiOrder.getOrders(token: customer_token ?? "") { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            print(response.data?.data)
            self.orders = response.data?.data ?? []
            self.filterOrderList(orders: self.orders)
            //print(self.orders)
        }
    }
    
    func filterOrderList(orders : [Datum]) -> ([Datum],[Datum]){
        newOrders = orders.filter{ $0.status == "New"}
        canceledOrders = orders.filter{ $0.status == "Cancelled"}
        return (newOrders,canceledOrders)
    }
    
    func numberOfSections() -> Int{
        return 1
    }
    
    func newOrderInSection(section:Int) -> Int{
        return newOrders.count
    }
    
    func canceledOrderInSection(section:Int) -> Int{
        return canceledOrders.count
    }
    
}
