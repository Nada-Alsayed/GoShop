//
//  Home_VC.swift
//  GoShop
//
//  Created by MAC on 10/12/2023.
//

import UIKit

class Home_VC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var personImg: UIImageView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionViewheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewAllLabel: UILabel!
    @IBOutlet weak var categoriesImg: UIImageView!
    
    //MARK: - Variables
    
    var viewModel = HomeViewModel()
    var banners = [Banner]()
    var products = [Product]()
    
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
        searchView.layer.cornerRadius = searchView.bounds.size.height / 2
        setUpCollectionViews()
        addAction()
        bindData()
        viewModel.getData()
    }
    
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
}
