//
//  UserAPI.swift
//  GoShop
//
//  Created by MAC on 03/12/2023.
//

import Foundation

class UserAPI:BaseAPI<UsersNetworking>{
   
    func postUser(user:User,compelition :@escaping (BaseResponse<Customer>?,Error?)->())
    {
        print("hhh")
        self.fetchData(target: .postUser(name: user.name, phone: user.phone, email: user.email, password: user.password, image: ""), responseClass: BaseResponse<Customer>.self) { result, err in
            print("A:\(result?.status)")
            print("A:\(result?.message)")
            compelition(result, nil)
        }
    }
}
