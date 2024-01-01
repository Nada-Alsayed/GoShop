//
//  AddressViewModel.swift
//  GoShop
//
//  Created by MAC on 27/12/2023.
//

import Foundation

class AddressViewModel{
    
    var addressAPI:AddressAPI = AddressAPI()
    var orderAPI:OrderAPI = OrderAPI()
    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    
    
    func postAddress(address:Address){
        addressAPI.addToAddresses(token: customer_token ?? "", latitude: address.latitude, longitude: address.longitude, city: address.city, region: address.region, addressDetails: address.details, name: address.name) { response, error in
            guard let response = response else { return }
         //   print("Addressrespose : \(response.message)")
            guard let address = response.data else {return}
            self.postOrder(address: address)
        }
    }
    
    func postOrder(address: Address){
        orderAPI.postOrder(token: customer_token ?? "", addressID: address.id, payMethod: 1, points: false, promoCode: 0) { response, error in
            guard let response = response else { return }
        }
    }
}
