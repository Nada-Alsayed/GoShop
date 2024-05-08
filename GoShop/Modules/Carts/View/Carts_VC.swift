//
//  Carts_VC.swift
//  GoShop
//
//  Created by MAC on 25/12/2023.
//

import UIKit

class Carts_VC: UIViewController {

    //MARK: -IBOutlets

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var cartEmptyImg: UIImageView!
    
    //MARK: -Variables

    var viewModel = CartViewModel()
    var data = DataClass()
    var products :[Favourite] = []
    
    //MARK: -View Controller LifeCycle

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

    //MARK: -IBActions

    @IBAction func navigateToCard(_ sender: Any) {
        checkIfCartEmpty(count: data.cartItems.count)
    }
    
    //MARK: -Methods

    func navigateToMap(){
        let vc = AddressMapKit_VC()
        vc.delegateReload = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
    }
   
    func navigateToAddresses_VC(){
        let vc = AllAddresses_VC()
        vc.delegateReload = self
        vc.destination = ConstantStrings.DESTINATION_CART
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
    }

    func bindData(){
        self.indicator.startAnimating()
        self.indicator.isHidden = false
        viewModel.bindResponseToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.data = self.viewModel.response
                self.products = self.viewModel.response.cartItems
                self.indicator.stopAnimating()
                self.hideEmptyImg(count: self.data.cartItems.count)
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
        self.totalPrice.text = "$\(data.total)"
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
