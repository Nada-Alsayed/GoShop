//
//  CartCell.swift
//  GoShop
//
//  Created by MAC on 25/12/2023.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var numberOfPices: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    static let id = String(describing: CartCell.self)
    var delegate : OnClickDelegate?
    var delegateReload : ReloadViewDelegate?
    var delegateQuantity : CartQuantityDelegate?
    var cellIndex : Int?
    var quantity : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        print("kkkkk")
        delegate?.clicked(cellIndex!, opertion: { state in
            print("deleted")
            if state{
                self.delegateReload?.reloadView()
            }
        })
        
    }
    
    @IBAction func decreaseBtn(_ sender: Any) {
        calculateQuantity(op: "-")
    }
    
    @IBAction func increaseBtn(_ sender: Any) {
        calculateQuantity(op: "+")
    }
    
    func setUpCellUI(){
//        containerView.layer.cornerRadius = 25
        productImg.layer.cornerRadius = 13
        //        containerView.layer.shadowColor = UIColor.darkGray.cgColor
//        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        containerView.layer.shadowOpacity = 0.6
//        containerView.layer.shadowRadius = 3.0
        stack.layer.cornerRadius = 20
        stack.layer.masksToBounds = true
    }
    
    func setUpData(product: Favourite){
        quantity = product.quantity ?? 1
        numberOfPices.text = "\(product.quantity ?? 1)"
        productTitle.text = product.product.name
        productPrice.text = calc(price: product.product.price ?? 0, quantity: product.quantity ?? 1)
        productImg.kf.setImage(with:URL(string: product.product.image ?? ""),placeholder: UIImage(named: "black logo"))
    }
    
    func calculateQuantity(op : String){
        if op == "+"{
            quantity?+=1
        }else{
            quantity?-=1
        }
        delegateQuantity?.clickedQuantity(cellIndex!,quantity ?? 1, opertion: { item in
            self.delegateReload?.reloadView()
        })
    }
    
    func calc(price : Double , quantity : Int)-> String{
        let total = Float(price * Double(quantity))
        return "\(total)"
    }
}
