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
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    
    //MARK: - Variables
    var selectedButton: UIButton?
    var animation : CAKeyframeAnimation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation!.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation!.duration = 0.25
        animation!.values =  [10,0]
        
        tabBarDesign()
        selectedButton = homeBtn
        setSelectedImage(homeBtn)
        showHomeVC()
    }
    
    func tabBarDesign(){
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
       // bottomView.layer.masksToBounds = true
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 2, height: 3)
        bottomView.layer.shadowOpacity = 0.8
        bottomView.layer.shadowRadius = 8.0
    }
    
    @IBAction func tabBarTapped(_ sender: UIButton) {
        guard sender != selectedButton else {
            return
        }
        
        if let previousSelectedButton = selectedButton {
            resetButtonImage(previousSelectedButton)
        }
        
        setSelectedImage(sender)
        selectedButton = sender
    }
    
    func resetButtonImage(_ button: UIButton) {
        let originalImageName = getImageNameForButtonTag(button.tag)
        let originalImage = UIImage(named: originalImageName)
        setButtonImage(button, image: originalImage)
    }
    
    func setSelectedImage(_ button: UIButton) {
        let selectedImageName = getSelectedImageNameForButtonTag(button.tag)
        let selectedImage = UIImage(named: selectedImageName)
        setButtonImage(button, image: selectedImage)
        switch button.tag {
        case 0:
            showHomeVC()
        case 1:
            showCartVC()
        case 2:
            showProfileVC()
        default:
            break
        }
    }
    
    func setButtonImage(_ button: UIButton, image: UIImage?) {
        UIView.transition(with: button, duration: 0.5, options: .curveLinear) {
            button.layer.add(self.animation!, forKey: "key")
            button.setImage(image, for: .normal)
        }
    }
    
    func getImageNameForButtonTag(_ tag: Int) -> String {
        switch tag {
        case 0: return "home"
        case 1: return "cart"
        case 2: return "profile"
        default: return ""
        }
    }
    
    func getSelectedImageNameForButtonTag(_ tag: Int) -> String {
        switch tag {
        case 0: return "selectedHome"
        case 1: return "selectedCart"
        case 2: return "selectedProfile"
        default: return ""
        }
    }
    func showHomeVC(){
        let vc = Home_VC()
        self.addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func showCartVC(){
        let vc = Carts_VC()
        self.addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func showProfileVC(){
        let vc = Profile_VC()
        self.addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
}
