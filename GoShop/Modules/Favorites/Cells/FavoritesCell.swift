//
//  FavoritesCell.swift
//  GoShop
//
//  Created by MAC on 24/12/2023.
//

import UIKit
import Kingfisher

class FavoritesCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var cartCellBtn: UIButton!
    
    static var id = String(describing: FavoritesCell.self)
    var delegteClick : OnClickDelegate?
    var delegateReload :ReloadViewDelegate?
    var cellIndex : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }
    
    func setCellUI(){
        containerView.layer.cornerRadius = 20
        img.layer.cornerRadius = 20
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.shadowRadius = 3.0
    }
    
    func setUpData(product: Favourite){
        name.text = product.product.name
        price.text = "\(Float(product.product.price ?? 0))$"
        img.kf.setImage(with:URL(string: product.product.image ?? ""),placeholder: UIImage(named: "black logo"))
    }
    
    func changeBtnTitle(product: Favourite){
      //  print("jj\(product.product.inCart)")
        if(product.product.inCart == true ){
            cartCellBtn.setTitle(" In Cart", for: .normal)
        }else if(product.product.inCart == false ){
            cartCellBtn.setTitle(" Add To Cart", for: .normal)
        }else{
            print("Cell Nil")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addBtn(_ sender: UIButton) {
        delegteClick?.clicked(cellIndex, opertion: { state in
            if state{
                sender.setTitle(" In Cart", for: .normal)
            }else{
                sender.setTitle(" Add To Cart", for: .normal)
            }
            self.delegateReload?.reloadView()
        })
    }
    
}
