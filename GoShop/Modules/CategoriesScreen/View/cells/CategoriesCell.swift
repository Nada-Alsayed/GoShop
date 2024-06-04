//
//  CategoriesCell.swift
//  GoShop
//
//  Created by MAC on 18/12/2023.
//

import UIKit
import Kingfisher

class CategoriesCell: UITableViewCell {
    
    //MARK: -IBOutlets

    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var stack: UIStackView!
    
    //MARK: -Variables

    var index: Int = 0
    static let identifier = String(describing: CategoriesCell.self)
    
    //MARK: -Cell Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }
    
    //MARK: -Methods

    override func updateConstraints() {
        super.updateConstraints()
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let subviewsOrder: [UIView]
        if index % 2 == 0 {
            subviewsOrder = [categoryImg, categoryLabel]
        } else {
            subviewsOrder = [categoryLabel, categoryImg]
        }
        subviewsOrder.forEach { stack.addArrangedSubview($0) }
    }
    
    func setCellUI(){
        myContentView.layer.cornerRadius = 20
        stack.layer.cornerRadius = 20
        stack.layer.masksToBounds = true
        myContentView.layer.shadowColor = UIColor.black.cgColor
        myContentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        myContentView.layer.shadowOpacity = 0.6
        myContentView.layer.shadowRadius = 5.0
    }
    
    func setupCell(category : Category , index : Int){
        categoryLabel.text = category.name
        categoryImg.kf.setImage(with:URL(string: category.image ?? ""),placeholder: UIImage(named: "black logo"))
    }
    
}
