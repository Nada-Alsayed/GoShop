//
//  Carts_VC.swift
//  GoShop
//
//  Created by MAC on 25/12/2023.
//

import UIKit

class Carts_VC: UIViewController {

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = CartViewModel()
    var products = [Favourite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.layer.cornerRadius = 25
        setUpTableView()
        bindData()
        viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func navigateToCard(_ sender: Any) {
        print("Navigate To Card")
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
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CartCell.id, bundle: nil), forCellReuseIdentifier: CartCell.id)
    }
}
