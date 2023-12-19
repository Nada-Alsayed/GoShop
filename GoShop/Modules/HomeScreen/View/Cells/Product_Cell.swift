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
    @IBOutlet weak var LoveView: UIView!
    @IBOutlet weak var loveImg: UIImageView!
    
    //MARK: -Variables
    
    static let id = String(describing: Product_Cell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellUI()
    }
    
    private func setUpCellUI(){
        productImg.layer.cornerRadius = 25
        discountView.layer.cornerRadius = discountView.bounds.size.height / 2
        LoveView.layer.cornerRadius = LoveView.bounds.size.height / 2
    }
    
    func setupCell(_ product : Product){
        productImg.kf.setImage(with:URL(string: product.image ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo54hpuEkGK1gxr7JFQ6e9J7JoVv_PaFVDZVr9fvbhJTBBiyRxUpcpA360_JbGE_nrMAk&usqp=CAU"))
        productTitle.text = product.name
        discountLabel.text = "\(Int(product.discount ?? 0))%"
        oldPrice.text = "\(Float(product.oldPrice ?? 0))"
        currentPrice.text = "\(Float(product.price ?? 0))"
    }
    

}
