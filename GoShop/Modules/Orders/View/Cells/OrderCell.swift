//
//  OrderCell.swift
//  GoShop
//
//  Created by MAC on 30/12/2023.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var stateLb: UILabel!
    @IBOutlet weak var dateL: UILabel!
    @IBOutlet weak var totalPriceL: UILabel!
    
    static let id = String(describing: OrderCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellUI(){
        container.layer.cornerRadius = 20
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowOpacity = 0.4
        container.layer.shadowRadius = 3.0
    }
    
    func setUPCell(order : Datum){
        totalPriceL.text = "$\(Float(order.total ?? 0))"
        dateL.text = order.date
        stateLb.text = order.status
    }
}
