//
//  categoryProductViewModel.swift
//  GoShop
//
//  Created by MAC on 02/01/2024.
//

import Foundation

class categoryProductViewModel{
    
    //MARK: - Variables
    
    private let api : CategoryAPI = CategoryAPI()
    var bindProductsToView : (()->()) = {}
    var products: [Product] = []{
        didSet{
            bindProductsToView()
        }
    }
    
    //MARK: - Methods

    func getData(category_id:Int){
        api.getData(categoryID: category_id) { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            self.products = response.data?.data ?? []
        }
    }
}
