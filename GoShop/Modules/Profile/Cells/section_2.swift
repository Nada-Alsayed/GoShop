//
//  section_2.swift
//  GoShop
//
//  Created by MAC on 23/12/2023.
//

import UIKit

class section_2: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    static let id = String(describing: section_2.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpData(name : String , imge : String){
        label.text = name
        img.image = UIImage(named: imge)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
