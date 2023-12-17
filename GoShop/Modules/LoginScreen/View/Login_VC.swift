//
//  Login_VC.swift
//  GoShop
//
//  Created by MAC on 10/12/2023.
//

import UIKit

class Login_VC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var appleView: UIView!
    
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupSubViewsDesign()
    }
    
    //MARK: - IBActions
    
    //MARK: - Methods
    
    func setupSubViewsDesign(){
        facebookView.layer.cornerRadius = 25
        facebookView.layer.borderWidth = 1
        facebookView.layer.borderColor = UIColor.darkGray.cgColor
        
        googleView.layer.cornerRadius = 25
        googleView.layer.borderWidth = 1
        googleView.layer.borderColor = UIColor.darkGray.cgColor
        
        appleView.layer.cornerRadius = 25
        appleView.layer.borderWidth = 1
        appleView.layer.borderColor = UIColor.darkGray.cgColor
    }
}
