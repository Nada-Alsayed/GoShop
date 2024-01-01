//
//  Favorites_VC.swift
//  GoShop
//
//  Created by MAC on 24/12/2023.
//

import UIKit

class Favorites_VC: UIViewController {
    
    //MARK: -IBOutlets

    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var favEmpty: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: -Variables

    var viewModel = FavoritesViewModel()
    var products = [Favourite]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.layer.cornerRadius = searchView.bounds.size.height / 2
        setUpTableView()
        addbackImgAction()
        bindData()
        viewModel.getData()
    }
    
    func bindData(){
        indicator.isHidden = false
        indicator.startAnimating()
        self.tableView.isUserInteractionEnabled = false
        viewModel.bindProductsToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.products = self.viewModel.products
//                print("iii\(self.viewModel.products[0].product.inCart)")
//                print("iii\(self.viewModel.products[1].product.inCart)")
//                print("pp\(self.products[0].product.inCart)")
//                print("pp\(self.products[1].product.inCart)")
                self.hideImage(array: self.products)
                self.indicator.stopAnimating()
                self.tableView.reloadData()
                self.tableView.isUserInteractionEnabled = true
            }
        }
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FavoritesCell.id, bundle: nil), forCellReuseIdentifier: FavoritesCell.id)
    }
    
    func addbackImgAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backImg.isUserInteractionEnabled = true
        backImg.addGestureRecognizer(tap)
    }
    
    @objc func goBack(){
        self.dismiss(animated: true)
    }
    
    func hideImage(array:[Favourite]){
        if array.count == 0{
            favEmpty.isHidden = false
        }else{
            favEmpty.isHidden = true
        }
    }
}
