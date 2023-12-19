//
//  Categories_VC.swift
//  GoShop
//
//  Created by MAC on 18/12/2023.
//

import UIKit

class Categories_VC: UIViewController {

    //MARK: -IBOutlets
    
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var categoriesTableView: UITableView!
    
    //MARK: - Variables
    
    var viewModel = CategoriesViewModel()
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        bindData()
        viewModel.getData()
    }
    func bindData(){
        viewModel.bindCategoriesToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.categories = self.viewModel.categories
                // self.indicator.stopAnimating()
                // self.indicatorView.isHidden = true
                self.categoriesTableView.reloadData()
            }
        }
    }
}
