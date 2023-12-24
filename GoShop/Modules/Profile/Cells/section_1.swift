//
//  section_1.swift
//  GoShop
//
//  Created by MAC on 23/12/2023.
//

import UIKit

class section_1: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    static let id = String(describing: section_1.self)
    let customer_name = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USERNAME)
    let customer_email = UserDefaults.standard.string(forKey: ConstantStrings.KEY_USEREMAIL)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
        setData()
    }
    
    func setUpUI(){
        userImg.layer.cornerRadius = 25
        containerView.layer.cornerRadius = 25
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowRadius = 3.0
    }
    
    func setData(){
        userName.text = customer_name ?? "nil"
        userEmail.text = customer_email ?? "nil"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
