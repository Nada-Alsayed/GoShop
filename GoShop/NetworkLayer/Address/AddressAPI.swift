//
//  AddressAPI.swift
//  GoShop
//
//  Created by MAC on 27/12/2023.
//

import Foundation

class AddressAPI : BaseAPI<AddressNetworking>{
    
    func addToAddresses(token: String, latitude:Double, longitude:Double, city:String, region:String, addressDetails:String, name:String , compelition :@escaping(BaseResponse<Address>?,Error?)->()){
        self.fetchData(target: .postAddress(token: token, latitude: latitude, longitude: longitude, city: city, region: region, addressDetails: addressDetails, name: name), responseClass: BaseResponse<Address>.self) {  response, err in
            guard let response = response else { return  compelition(nil,err) }
            print("posted")
            compelition(response, nil)
        }
    }
    
    func getAddresses(token:String, compelition :@escaping (BaseResponse<MyData<[Address]>>?,Error?)->()){
        self.fetchData(target: .getAddresses(token: token), responseClass: BaseResponse<MyData<[Address]>>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
            print("Feched")
            compelition(response, nil)
        }
    }
    
    func deleteAddresses(token:String, id:Int, compelition :@escaping (BaseResponse<Address>?,Error?)->()){
        self.fetchData(target: .deleteAddress(token: token, id: id), responseClass: BaseResponse<Address>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
            print("Deleted")
            compelition(response, nil)
        }
    }
}
