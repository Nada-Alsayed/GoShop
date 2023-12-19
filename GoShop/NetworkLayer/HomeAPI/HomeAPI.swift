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
        self.fetchData(target: .getData, responseClass: BaseResponse<HomeData>.self) { response, err in
            guard let response = response else { return  compelition(nil,err) }
          //  print("hhhhh")
            compelition(response, nil)
        }
    }
}
