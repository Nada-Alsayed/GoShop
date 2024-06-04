//
//  CategoryAPI.swift
//  GoShop
//
//  Created by MAC on 03/01/2024.
//

import Foundation

class CategoryAPI:BaseAPI<CategoryNetworking>{
    
    func getData(categoryID:Int,compelition :@escaping (BaseResponse<MyData<[Product]>>?,Error?)->())
    {
        guard let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN) else {
            print("No username found.")
            return
        }
        
        self.fetchData(target: .getData(category_id: categoryID, token: customer_token), responseClass: BaseResponse<MyData<[Product]>>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
            compelition(response, nil)
        }
    }
}
