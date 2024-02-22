//
//  Home_VC.swift
//  GoShop
//
//  Created by MAC on 10/12/2023.
//

import UIKit

class Home_VC: UIViewController {
    
    //MARK: - IBOutlets
  
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var personImg: UIImageView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionViewheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var categoriesImg: UIImageView!
    
    //MARK: - Variables
    
    var viewModel = HomeViewModel()
    var cartViewModel = CartViewModel()
    var banners = [Banner]()
    var products = [Product]()
    var cartItems = [Favourite]()
    var sum = 0
    
    //MARK: - View Controller LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        productsCollectionView.addObserver(self, forKeyPath: "contentSize",options: .new , context: nil)
        productsCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        productsCollectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", let collectionView = object as? UICollectionView, collectionView == productsCollectionView {
            if let newvalue = change?[.newKey] as? CGSize {
                productCollectionViewheightConstraint.constant = newvalue.height
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.layer.cornerRadius = 20
        searchView.layer.cornerRadius = searchView.bounds.size.height / 2
        setUpCollectionViews()
        addAction()
        bindData()
        viewModel.getData()
        bindCartItemsNumber()
        cartViewModel.getData()
    }
    
    //MARK: - Methods
    
    func bindData(){
        self.indicator.startAnimating()
        self.indicator.isHidden = false
        viewModel.bindProductsToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.banners = self.viewModel.banners
                self.products = self.viewModel.products
                self.indicator.stopAnimating()
                self.bannerCollectionView.reloadData()
                self.productsCollectionView.reloadData()
                self.productsCollectionView.isUserInteractionEnabled = true
            }
        }
    }
    
    func bindCartItemsNumber(){
        cartViewModel.bindResponseToView = {[weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.cartItems = self.cartViewModel.response.cartItems
                self.sumCartItems(products: self.cartItems)
            }
        }
    }
    
    func addAction(){
        let tap_1 = UITapGestureRecognizer(target: self, action: #selector(moveToCategory) )
        categoriesImg.isUserInteractionEnabled = true
        categoriesImg.addGestureRecognizer(tap_1)
    }
    
    @objc func moveToCategory(){
        let vc = Categories_VC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func sumCartItems(products:[Favourite]){
        sum = 0
        for i in products{
            print ("hhh\(i.quantity ?? 0)")
            sum += i.quantity ?? 0
        }
        setCartItemsNumber(sum: sum)
    }
    
    func setCartItemsNumber(sum:Int){
        UserDefaults.standard.setValue(sum, forKey: ConstantStrings.KEY_Cart_ITEMS)
        self.itemsLabel.text = "\(sum )"
    }
}
