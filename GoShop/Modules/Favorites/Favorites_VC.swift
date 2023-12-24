//
//  Favorites_VC.swift
//  GoShop
//
//  Created by MAC on 24/12/2023.
//

import UIKit

class Favorites_VC: UIViewController {
    
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
   
    var viewModel = FavoritesViewModel()
    var products = [Favourite]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.layer.cornerRadius = searchView.bounds.size.height / 2
        addbackImgAction()
        setUpCollectionView()
        bindData()
        viewModel.getData()
    }
    
    func bindData(){
        viewModel.bindProductsToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.products = self.viewModel.products
                // self.indicator.stopAnimating()
                // self.indicatorView.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
    func setUpCollectionView(){
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

}
