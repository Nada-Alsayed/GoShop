//
//  ImagePagerCell.swift
//  GoShop
//
//  Created by MAC on 22/12/2023.
//

import UIKit
import Kingfisher

class ImagePagerCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
   
    static let id = String(describing: ImagePagerCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(url:String){
        productImage.kf.setImage(with:URL(string: url),placeholder: UIImage(named: "black logo"))
    }
}
