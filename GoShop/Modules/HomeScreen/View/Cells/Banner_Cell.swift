//
//  Banner_Cell.swift
//  GoShop
//
//  Created by MAC on 13/12/2023.
//

import UIKit

class Banner_Cell: UICollectionViewCell {

    //MARK: -IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bannerImg: UIImageView!
    
    //MARK: -Variables

    static let id = String(describing: Banner_Cell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
