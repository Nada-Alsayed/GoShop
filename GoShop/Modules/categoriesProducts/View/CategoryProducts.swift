//
//  CategoryProducts.swift
//  GoShop
//
//  Created by MAC on 02/01/2024.
//

import UIKit

class CategoryProducts: UIViewController {
    
    //MARK: -IBOutlets

    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: -Variables

    var products : [Product] = []
    var homeView = HomeViewModel()
    var categoryViewModel = categoryProductViewModel()
    var id :Int?
    var categoryName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenTitle.text = categoryName ?? "Category"
        addbackImgAction()
        setUpCollectionViews()
        bindData()
        categoryViewModel.getData(category_id:id ?? 0)
    }
    
    //MARK: - Methods
    
    func bindData(){
        self.indicator.startAnimating()
        self.indicator.isHidden = false
        categoryViewModel.bindProductsToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.products = self.categoryViewModel.products
                self.indicator.stopAnimating()
                self.collectionView.reloadData()
                self.collectionView.isUserInteractionEnabled = true
            }
        }
    }
    
    func addbackImgAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backBtn.isUserInteractionEnabled = true
        backBtn.addGestureRecognizer(tap)
    }
    
    @objc func goBack(){
        self.dismiss(animated: true)
    }
}
