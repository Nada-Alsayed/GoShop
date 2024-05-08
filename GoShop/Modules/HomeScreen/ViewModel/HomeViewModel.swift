//
//  HomeViewModel.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import Foundation
import UIKit

class HomeViewModel{
    
    //MARK: - Variables
    
    private let api : HomeAPI = HomeAPI()
    private let apiWishlist : WishlistAPI = WishlistAPI()
    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    var bindProductsToView : (()->()) = {}
    var banners: [Banner] = []
    var products: [Product] = []{
        didSet{
            bindProductsToView()
        }
    }
    
    //MARK: - Methods
    
    func numberOfSections() -> Int{
        return 1
    }
    
    func bannersNumberInSection(section:Int) -> Int{
        return banners.count
    }
    
    func productsNumberInSection(section:Int) -> Int{
        return products.count
    }
    
    func getData(){
        api.getData { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            self.banners = response.data?.banners ?? []
            self.products = response.data?.products ?? []
        }
    }
    
    func postToWishlist(product_id: Double,vc:UIViewController,operation:@escaping()->()){
        apiWishlist.postToWishlist(token: customer_token ?? "nil", product_ID: product_id) { response, error in
            guard let response = response else {return}
            print(response.message!)
            
            vc.showToast(controller: vc, message: response.message!, seconds: 0.8)
            operation()
        }
    }
}
