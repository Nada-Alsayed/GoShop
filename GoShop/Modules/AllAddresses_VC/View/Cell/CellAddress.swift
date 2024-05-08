//
//  CellAddress.swift
//  GoShop
//
//  Created by MAC on 28/12/2023.
//

import UIKit

class CellAddress: UITableViewCell {    

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var checkedImg: UIImageView!
    
    static let id = String(describing: CellAddress.self)
    var cellIndex:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // setTapGesture()
        setUpCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      //  checkedImg.isHidden = false
        // Configure the view for the selected state
    }
    
    func setUpCellUI(){
        container.layer.cornerRadius = 25
        container.layer.shadowColor = UIColor.darkGray.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowOpacity = 0.6
        container.layer.shadowRadius = 3.0
    }
    
    func setUpData(address: Address){
        name.text = "Address"
        details.text = address.details
        city.text = address.city
        country.text = address.region
    }
    
    func showImage(){
        checkedImg.isHidden = false
    }
    
    func hideImage(){
        checkedImg.isHidden = true
    }
    
//    func setTapGesture(){
//        let tap = UITapGestureRecognizer(target: self, action: #selector(selectAddress))
//        checkedImg.isUserInteractionEnabled = true
//        checkedImg.addGestureRecognizer(tap)
//    }
//
//    @objc func selectAddress(){
//        print("Vooo :)")
//    }
    
}


