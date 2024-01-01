//
//  Details_VC.swift
//  GoShop
//
//  Created by MAC on 21/12/2023.
//

import UIKit

class Details_VC: UIViewController {
    
    //MARK: -IBOutLets
    
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var pageControler: UIPageControl!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescribtion: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
   
    //MARK: -Variables
    
    var viewModel : DetailsViewModel = DetailsViewModel()
    var id: Double = 0.0
    var delegate : ReloadViewDelegate?
    var product:Product?
    var currentPage = 0 {
        didSet {
            pageControler.currentPage = currentPage
        }
    }
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        bindData()
        viewModel.getData(product_id:id )
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
        //print("inRt : \(product?.inCart)")
        if product?.inCart == false {
            product?.inCart = true
            viewModel.postToCart(product_id: (product?.id)! , vc: self)
            cartBtn.setTitle(" In Cart", for: .normal)
        }else{
            showAlertWithAction(title: ConstantStrings.ALERT, titleAction:  ConstantStrings.DELETE_BTN, titleNoAction:  ConstantStrings.NO_ACTION_BTN, message:  ConstantStrings.CONFIRM_DELETE_CART, viewController: self) {
              //  print("inRt3 : \(self.product?.inCart)")
             //   self.product?.inCart = false
               // print("inRt3 : \(self.product?.inCart)")
                self.viewModel.postToCart(product_id: (self.product?.id)! , vc: self)
                self.cartBtn.setTitle(" Add To Cart", for: .normal)
              //  print("inRt3 : \(self.product?.inCart)")

            }
        }
    }
    
    //MARK: -Methods
    
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
     //   print("inRt2 : \(product?.inCart)")
     //   print("inFav2 : \(product?.inFavorites)")

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
}
