//
//  HomeAPI.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation

class HomeAPI:BaseAPI<HomeNetworking>{
   
    func getData(compelition :@escaping (Response?,Error?)->())
    {
        self.fetchData(target: .getData, responseClass: Response.self) { response, err in
            compelition(response, nil)
        }
    }
}
