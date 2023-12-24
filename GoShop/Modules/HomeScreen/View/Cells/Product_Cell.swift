//
//  Product_Cell.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import UIKit

class Product_Cell: UICollectionViewCell {
    
    //MARK: -IBOutlets

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var discountLabel: UILabel!

    @IBOutlet weak var favouriteBtn: UIButton!
    
    //MARK: -Variables
    
    static let id = String(describing: Product_Cell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellUI()
    }
    
    private func setUpCellUI(){
        productImg.layer.cornerRadius = 25
        discountView.layer.cornerRadius = discountView.bounds.size.height / 2
    }
    
    func setupCell(_ product : Product){
        checkIfDiscountExist(value: Int(product.discount ?? 0))
        productImg.kf.setImage(with:URL(string: product.image ?? ""),placeholder: UIImage(named: "black logo"))
        productTitle.text = product.name
        discountLabel.text = "\(Int(product.discount ?? 0))%"
        oldPrice.text = "\(Float(product.oldPrice ?? 0))$"
        currentPrice.text = "\(Float(product.price ?? 0))$"
        if product.inFavorites ?? false {
            favouriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            favouriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func addToFavorites(_ sender: UIButton) {
    }
    
    func checkIfDiscountExist(value:Int){
        if value == 0{
            discountView.isHidden = true
        }else{
            discountView.isHidden = false
        }
    }

}
