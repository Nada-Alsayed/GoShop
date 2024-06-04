//
//  OnBoardingCell.swift
//  GoShop
//
//  Created by MAC on 17/12/2023.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {
    
    static let identifier  = String(describing: OnBoardingCell.self)
    
    @IBOutlet weak var slideImg: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideDescription: UILabel!
    
    func setUpCell(_ slide : OnBoardingSlide){
        slideImg.layer.cornerRadius = 20
        slideImg.image = slide.img
        slideTitle.text = slide.title
        slideDescription.text = slide.description
    }
    
}
