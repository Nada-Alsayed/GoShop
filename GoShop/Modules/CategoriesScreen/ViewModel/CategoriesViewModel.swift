//
//  CategoriesViewModel.swift
//  GoShop
//
//  Created by MAC on 18/12/2023.
//

import Foundation

class CategoriesViewModel{
    
    //MARK: - Variables
    
    private let api : CategoriesAPI = CategoriesAPI()
    var bindCategoriesToView : (()->()) = {}
    var categories: [Category] = []{
        didSet{
            bindCategoriesToView()
        }
    }

    //MARK: - Methods

    func numberOfSections() -> Int{
        return 1
    }
    
    func categoriesNumberInSection(section:Int) -> Int{
        return categories.count
    }
    
    func getData(){
        api.getData { [weak self] response, error in
            guard let self = self else{return}
            guard let response = response else {return}
            self.categories = response.data?.data ?? []
        }
    }
}
