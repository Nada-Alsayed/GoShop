//
//  Home_VC.swift
//  GoShop
//
//  Created by MAC on 10/12/2023.
//

import UIKit

class Home_VC: UIViewController {
    
    //MARK: -IBOutlets

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionViewheightConstraint: NSLayoutConstraint!
    
    //MARK: -Variables

   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionViews()
    }

}
