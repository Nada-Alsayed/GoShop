//
//  BottomTaPBar.swift
//  GoShop
//
//  Created by MAC on 10/12/2023.
//

import UIKit

class BottomTaPBar: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var homeViewOnClick: UIView!
    @IBOutlet weak var homeViewDefault: UIView!
    @IBOutlet weak var homeOnClickBG: UIView!
    @IBOutlet weak var homeOnClickImgView: UIView!
    @IBOutlet weak var homeDefaultImgView: UIView!
    @IBOutlet weak var homeView: UIStackView!
    
    @IBOutlet weak var cartView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    
    //MARK: - Variables

    var isHomeSelected = true
    var isFavoriteSelected = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showHomeVC()
        tabBarDesign()
        addTapRecogniser()
    }

    func addTapRecogniser(){
        let homeTap = UITapGestureRecognizer(target: self, action: #selector(homeStackOnClick))
        homeView.isUserInteractionEnabled = true
        homeView.addGestureRecognizer(homeTap)
        
        
        let favoriteTap = UITapGestureRecognizer(target: self, action: #selector(favoriteStackOnClick))
        cartView.isUserInteractionEnabled = true
        cartView.addGestureRecognizer(favoriteTap)
    }
    
    func tabBarDesign(){
        homeViewOnClick.isHidden = true
        homeViewDefault.isHidden = false
        homeDefaultImgView.layer.cornerRadius = 20
        bottomView.layer.cornerRadius = 25
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 0, height: 4)
        bottomView.layer.shadowOpacity = 0.8
        bottomView.layer.shadowRadius = 5.0
    }
    
    func showHomeVC(){
        let home = Home_VC()
        self.addChild(home)
        home.view.frame = containerView.bounds
        containerView.addSubview(home.view)
        home.didMove(toParent: self)
    }
    
    @objc func homeStackOnClick(){
        if isHomeSelected == false {
            homeViewOnClick.isHidden = false
            homeViewDefault.isHidden = true
            homeOnClickBG.layer.cornerRadius = 20
            homeOnClickBG.layer.masksToBounds = true
            homeOnClickImgView.layer.cornerRadius = 20
            isFavoriteSelected = false
            isHomeSelected = true
            showHomeVC()
        }
    }
    
    @objc func favoriteStackOnClick(){
        if isFavoriteSelected == false {
            homeViewOnClick.isHidden = true
            homeViewDefault.isHidden = false
            homeDefaultImgView.layer.cornerRadius = 20
            homeDefaultImgView.layer.masksToBounds = true
            isFavoriteSelected = true
            isHomeSelected = false
            
        }
    }

}
