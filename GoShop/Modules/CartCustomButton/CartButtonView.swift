//
//  CartButtonView.swift
//  GoShop
//
//  Created by MAC on 08/01/2024.
//

import UIKit


final class CartButtonView: UIView {
    @IBOutlet var contentView: CartButtonView!
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var label: UILabel!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        self.configureView()
    }
    
    private func configureView(){
        let nib = UINib(nibName: "CartButtonView", bundle: nil)
        nib.instantiate(withOwner: self,options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
    }
    
    func configureLabel(title:String){
        label.text = title
    }
}
