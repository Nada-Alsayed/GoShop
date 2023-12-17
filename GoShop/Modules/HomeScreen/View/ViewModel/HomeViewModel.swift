//
//  HomeViewModel.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation

class HomeViewModel{
    
    //MARK: - Variables

    private let api : HomeAPI = HomeAPI()
    var banners: [Banner]?
    var products: [Product]?
    
    //MARK: - Methods

    func numberOfSections() -> Int{
        return 1
    }
    
    func bannersNumberInSection(section:Int) -> Int{
        return banners?.count ?? 0
    }
    
    func productsNumberInSection(section:Int) -> Int{
        return products?.count ?? 0
    }
    
    func getData(){
        api.getData { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            self.banners = response.data.banners
            self.products = response.data.products
        }
    }
}
