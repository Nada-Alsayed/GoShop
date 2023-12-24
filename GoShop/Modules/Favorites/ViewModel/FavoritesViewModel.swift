//
//  FavoritesViewModel.swift
//  GoShop
//
//  Created by MAC on 24/12/2023.
//

import Foundation
class FavoritesViewModel{
    
    //MARK: - Variables
    
    private let api : WishlistAPI = WishlistAPI()
    let customer_token = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USER_TOKEN)
    var bindProductsToView : (()->()) = {}
    var products: [Favourite] = []{
        didSet{
            bindProductsToView()
        }
    }

    //MARK: - Methods

    func numberOfSections() -> Int{
        return 1
    }
    
    func productsNumberInSection(section:Int) -> Int{
        return products.count
    }
    
    func getData(){
        api.getFromWishlist(token:customer_token ?? "nil" ) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            print(response.data?.data)
            self.products = response.data?.data ?? []
        }
    }
}
