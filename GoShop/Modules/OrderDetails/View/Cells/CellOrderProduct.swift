//
//  CellOrderProduct.swift
//  GoShop
//
//  Created by MAC on 31/12/2023.
//

import UIKit

class CellOrderProduct: UICollectionViewCell {

   
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    static let id = String(describing: CellOrderProduct.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }
    
    func setCellUI(){
        container.layer.cornerRadius = 20
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowOpacity = 0.4
        container.layer.shadowRadius = 3.0
    }
    
    func setUpData(product: Product){
        title.text = product.name
        price.text = "\(Float(product.price ?? 0))$"
        img.kf.setImage(with:URL(string: product.image ?? ""),placeholder: UIImage(named: "black logo"))
    }

}
