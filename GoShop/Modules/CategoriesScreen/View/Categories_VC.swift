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
    
    //MARK: -View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        addbackImgAction()
        bindData()
        viewModel.getData()
    }
    
    //MARK: -Methods

    func bindData(){
        viewModel.bindCategoriesToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.categories = self.viewModel.categories
                self.categoriesTableView.reloadData()
            }
        }
    }
    
    func addbackImgAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backImg.isUserInteractionEnabled = true
        backImg.addGestureRecognizer(tap)
    }
    
    @objc func goBack(){
        self.dismiss(animated: true)
    }
}
