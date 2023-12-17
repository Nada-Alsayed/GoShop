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
    
    func setUpCellUI(){
        containerView.layer.cornerRadius = 25
        productImg.layer.cornerRadius = 25
        discountView.layer.cornerRadius = discountView.bounds.size.height / 2
        LoveView.layer.cornerRadius = LoveView.bounds.size.height / 2
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 2, height: 4)
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowRadius = 3.0
    }

}
