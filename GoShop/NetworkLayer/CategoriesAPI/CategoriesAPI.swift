//
//  CategoriesAPI.swift
//  GoShop
//
//  Created by MAC on 18/12/2023.
//

import Foundation

class CategoriesAPI:BaseAPI<CategoriesNetworking>{
    func getData(compelition :@escaping (BaseResponse<CategoryData>?,Error?)->())
    {
        self.fetchData(target: .getData, responseClass: BaseResponse<CategoryData>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
          //  print("hhhhh")
            compelition(response, nil)
        }
    }
}
