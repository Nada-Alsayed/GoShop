//
//  Details_VC.swift
//  GoShop
//
//  Created by MAC on 21/12/2023.
//

import UIKit

class Details_VC: UIViewController {
    
    //MARK: -IBOutLets
    
    @IBOutlet weak var cartItemsLabel: UILabel!
    @IBOutlet weak var cartItemsView: UIView!
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var pageControler: UIPageControl!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescribtion: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    
    //MARK: -Variables
    
    var viewModel : DetailsViewModel = DetailsViewModel()
    var cartViewModel = CartViewModel()
    var delegate : ReloadViewDelegate?
    var cartItems = [Favourite]()
    var id: Double = 0.0
    var product:Product?

    var sum = 0
    var currentPage = 0 {
        didSet {
            pageControler.currentPage = currentPage
        }
    }
    
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartItemsView.layer.cornerRadius = 20
        addbackImgAction()
        setUpCollectionView()
        bindData()
        viewModel.getData(product_id:id )
        cartItemsLabel.text = UserDefaults.standard.string(forKey: ConstantStrings.KEY_Cart_ITEMS)
        bindCartItemsNumber()
        cartViewModel.getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            delegate?.reloadView()
        }
    }
    
    
    //MARK: -IBActions
    
    @IBAction func addToFavourite(_ sender: Any) {
       // print("inFav : \(product?.inFavorites)")
        if(product?.inFavorites == false){
            product?.inFavorites = true
            viewModel.postToWishlist(product_id: (product?.id)! , vc: self)
            favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            showAlertWithAction(title: ConstantStrings.ALERT, titleAction:  ConstantStrings.DELETE_BTN, titleNoAction:  ConstantStrings.NO_ACTION_BTN, message:  ConstantStrings.CONFIRM_DELETE_WISHLIST, viewController: self) {
                self.product?.inFavorites = false
                self.viewModel.postToWishlist(product_id: (self.product?.id)! , vc: self)
                self.favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if product?.inCart == false {
            product?.inCart = true
            viewModel.postToCart(product_id: (product?.id)! , vc: self){
                self.cartBtn.setTitle(" In Cart", for: .normal)
                self.bindCartItemsNumber()
                self.cartViewModel.getData()
            }
        }else{
            showAlertWithAction(title: ConstantStrings.ALERT, titleAction:  ConstantStrings.DELETE_BTN, titleNoAction:  ConstantStrings.NO_ACTION_BTN, message:  ConstantStrings.CONFIRM_DELETE_CART, viewController: self) {
                self.viewModel.postToCart(product_id: (self.product?.id)! , vc: self){
                    self.cartBtn.setTitle(" Add To Cart", for: .normal)
                    self.bindCartItemsNumber()
                    self.cartViewModel.getData()
                }
            }
        }
    }
    
    //MARK: -Methods
    
    func addbackImgAction(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backImg.isUserInteractionEnabled = true
        backImg.addGestureRecognizer(tap)
    }
    
    @objc func goBack(){
        self.dismiss(animated: true)
    }
    
    func setUpCollectionView(){
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.register(UINib(nibName: ImagePagerCell.id, bundle: nil), forCellWithReuseIdentifier: ImagePagerCell.id)
    }
    
    func setUpData(){
        productTitle.text = product?.name
        productDescribtion.text = product?.description
        productPrice.text = "\(Float(product?.price ?? 0))$"
        pageControler.numberOfPages = product?.images?.count ?? 0
        checkIfInFavorites(bool: product?.inFavorites ?? false)
        checkIfInCart(bool: product?.inCart ?? false)
    }
    
    func bindData(){
        viewModel.bindProductToView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.product = self.viewModel.product
                self.setUpData()
                self.imageCollection.reloadData()
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
    
    func checkIfInFavorites(bool : Bool){
        if bool {
            favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func checkIfInCart(bool : Bool){
        if bool {
           cartBtn.setTitle(" In Cart", for: .normal)
           // cartBtn.titleLabel?.text = "In Cart"
        }else{
          cartBtn.setTitle(" Add To Cart", for: .normal)
            //cartBtn.titleLabel?.text = "Add To Cart"
        }
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
        self.cartItemsLabel.text = "\(sum )"
    }
}
