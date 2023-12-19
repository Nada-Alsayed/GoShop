//
//  Banner_Cell.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import UIKit
import Kingfisher

class Banner_Cell: UICollectionViewCell {
    
    //MARK: -IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bannerImg: UIImageView!
    
    //MARK: -Variables
    
    static let id = String(describing: Banner_Cell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }
    
    func setCellUI(){
        containerView.layer.cornerRadius = 20
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowRadius = 5.0
        containerView.layer.masksToBounds = true
    }
    
    func setupCell(_ banner : Banner){
        bannerImg.kf.setImage(with:URL(string: banner.image ?? ""))
        
    }
    
}
