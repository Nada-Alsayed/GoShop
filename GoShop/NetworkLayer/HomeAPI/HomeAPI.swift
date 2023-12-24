//
//  HomeAPI.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation

class HomeAPI:BaseAPI<HomeNetworking>{
    
    func getData(compelition :@escaping (BaseResponse<HomeData>?,Error?)->())
    {
        guard let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN) else {
            
            print("No username found.")
            return 
        }
        
        self.fetchData(target: .getData(token: customer_token), responseClass: BaseResponse<HomeData>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
          //  print("hhhhh")
            compelition(response, nil)
        }
    }
}
