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
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var cartEmptyImg: UIImageView!
    
    var viewModel = CartViewModel()
    var products = [Favourite]()
    var price: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.layer.cornerRadius = 13
        setUpTableView()
        bindData()
        viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func navigateToCard(_ sender: Any) {
        checkIfCartEmpty(count: products.count)
    }
    
    func navigateToMap(){
        let vc = AddressMapKit_VC()
        vc.delegateReload = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
    }
   
    func navigateToAddresses_VC(){
        let vc = AllAddresses_VC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
    }

    func bindData(){
        self.indicator.startAnimating()
        self.indicator.isHidden = false
        viewModel.bindProductsToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.products = self.viewModel.products
                self.indicator.stopAnimating()
                self.hideEmptyImg(count: self.products.count)
                self.calcTotalPrice()
                self.tableView.reloadData()
                self.tableView.isUserInteractionEnabled = true
            }
        }
    }
    
    func checkIfCartEmpty(count : Int){
            if count == 0{
                self.showToast(controller: self, message: "Cart is Empty", seconds: 0.8)
            }else{
                self.order()
            }
    }
    
    func order(){
        showAlertWithTwoAction(title: ConstantStrings.ALERT, titleAction: ConstantStrings.NEW_ADDRESS_BTN, titleNoAction: ConstantStrings.EXISTED_ADDRESS_BTN, message: ConstantStrings.CHOOSE_METHOD_TO_GET_ADDRESS, viewController: self) {
            self.navigateToMap()
        } compilitionHandler2: {
            self.navigateToAddresses_VC()
        }
    }
    
    func calcTotalPrice(){
        for product in products{
            self.price += product.product.price ?? 0
        }
        self.totalPrice.text = "$\(self.price)"
    }
    
    func hideEmptyImg(count:Int){
        if count == 0{
            cartEmptyImg.isHidden = false
        }else{
            cartEmptyImg.isHidden = true
        }
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CartCell.id, bundle: nil), forCellReuseIdentifier: CartCell.id)
    }
}
