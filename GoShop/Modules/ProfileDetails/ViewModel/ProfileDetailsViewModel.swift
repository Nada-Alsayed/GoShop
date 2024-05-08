//
//  ProfileDetailsViewModel.swift
//  GoShop
//
//  Created by MAC on 01/01/2024.
//

import Foundation

class profileDetailsViewModel{
    
    //MARK: -Variables

    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    let email = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USEREMAIL)
    let name = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USERNAME)
    var bindDataToView : ()->() = {}
    var api = UserAPI()
    var customer = Customer(){
        didSet{
            bindDataToView()
        }
    }
    
    //MARK: -Methods

    func logOutFromAPI(operation : @escaping()->()){
        api.logOutUser(token: customer_token ?? "") { response, error in
            self.customer = response?.data ?? Customer()
            operation()
        }
    }
    
    func getData(){
        customer = Customer(name: name ?? "", phone: "", email: email ?? "", id: 0, image: "", token: customer_token ?? "")
    }
}
