//
//  AddressViewModel.swift
//  GoShop
//
//  Created by MAC on 27/12/2023.
//

import Foundation

class AddressViewModel{
    
    //MARK: -Variables

    var addressAPI:AddressAPI = AddressAPI()
    var orderAPI:OrderAPI = OrderAPI()
    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    
    //MARK: -Methods

    func postAddress(address:Address, compeletionHandeler : @escaping()->()){
        addressAPI.addToAddresses(token: customer_token ?? "", latitude: address.latitude, longitude: address.longitude, city: address.city, region: address.region, addressDetails: address.details, name: address.name) { response, error in
            guard let response = response else { return }
            guard let address = response.data else {return}
            compeletionHandeler()
//            self.postOrder(address: address){
//                compeletionHandeler()
//            }
        }
    }
    
    func postOrder(address: Address, compeletionHandeler : @escaping()->()){
        orderAPI.postOrder(token: customer_token ?? "", addressID: address.id, payMethod: 1, points: false, promoCode: 0) { response, error in
            guard let response = response else { return }
            compeletionHandeler()
        }
    }
}
