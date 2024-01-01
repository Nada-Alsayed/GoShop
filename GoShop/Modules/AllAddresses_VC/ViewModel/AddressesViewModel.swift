//
//  AddressesViewModel.swift
//  GoShop
//
//  Created by MAC on 28/12/2023.
//

import Foundation

class AddressesViewModel{
    
    private let api : AddressAPI = AddressAPI()
    private let apiCart : CartAPI = CartAPI()
    var orderAPI:OrderAPI = OrderAPI()
    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    var bindAddressesToView : (()->()) = {}
    var addresses: [Address] = []{
        didSet{
            bindAddressesToView()
        }
    }
    var cartlistBind : (()->()) = {}
    var cartlist: [Favourite] = []{
        didSet{
            cartlistBind()
        }
    }
    
    //MARK: - Methods

    func numberOfSections() -> Int{
        return 1
    }
    
    func addressesNumberInSection(section:Int) -> Int{
        return addresses.count
    }
    
    func getData(){
        api.getAddresses(token:customer_token ?? "nil" ) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
           // print(response.data?.data)
            self.addresses = response.data?.data ?? []
        }
    }
    
    func deleteAddress(id:Int,operation:@escaping ()->()){
        api.deleteAddresses(token:customer_token ?? "nil", id: id ) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            print(response.message)
            operation()
        }
    }
    
    func postOrder(address: Address,operation:@escaping ()->()){
        orderAPI.postOrder(token: customer_token ?? "", addressID: address.id, payMethod: 1, points: false, promoCode: 0) { response, error in
            guard let response = response else { return }
            operation()
        }
    }
    
    func getCartData(operation:@escaping ()->()){
        apiCart.getFromCart(token:customer_token ?? "nil" ) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            self.cartlist = response.data?.cartItems ?? []
            operation()
        }
    }
}
