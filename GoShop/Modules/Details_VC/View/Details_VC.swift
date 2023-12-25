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
    
    override func viewWillAppear(_ animated: Bool) {
        if product?.inFavorites ?? false {
            favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    //MARK: -IBActions

    @IBAction func addToFavourite(_ sender: Any) {
        //print("addtofav")
        viewModel.postToWishlist(product_id: (product?.id)! , vc: self)
        favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    @IBAction func addToCart(_ sender: Any) {
       // print("addtocart")
        viewModel.postToCart(product_id: (product?.id)! , vc: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            delegate?.reloadView()
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
}
