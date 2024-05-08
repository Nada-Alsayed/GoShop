//
//  AddressCell.swift
//  GoShop
//
//  Created by MAC on 28/12/2023.
//

import UIKit

class AddressCell: UITableViewCell {

    
    
    
    
    static let id = String(describing: AddressCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCellUI(){
//        containerView.layer.cornerRadius = 25
//        containerView.layer.shadowColor = UIColor.darkGray.cgColor
//        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        containerView.layer.shadowOpacity = 0.6
//        containerView.layer.shadowRadius = 3.0
    }
    
    func setUpData(address: Address){
//        productTitle.text = product.product.name
//        productPrice.text = "\(Float(product.product.price ?? 0))$"
//        productImg.kf.setImage(with:URL(string: product.product.image ?? ""),placeholder: UIImage(named: "black logo"))
    }
}
