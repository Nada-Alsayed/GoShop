//
//  CategoriesCell.swift
//  GoShop
//
//  Created by MAC on 18/12/2023.
//

import UIKit

class CategoriesCell: UITableViewCell {

    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var myContentView: UIView!
    
    static let identifier = String(describing: CategoriesCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupCell(category : Category){
        categoryLabel.text = category.name
        categoryImg.kf.setImage(with:URL(string: category.image ?? ""))
    }
    
}
