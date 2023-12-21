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
    
    //MARK: - Variables
    var viewModel = LoginViewModel()
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupSubViewsDesign()
        addActions()
    }
    
    //MARK: - IBActions

    @IBAction func loginBtn(_ sender: Any) {
        print("login")

    }
    
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
    
    func addActions(){
        let tap_1 = UITapGestureRecognizer(target: self, action: #selector(signInWithApple) )
        facebookView.isUserInteractionEnabled = true
        facebookView.addGestureRecognizer(tap_1)
        
        let tap_2 = UITapGestureRecognizer(target: self, action: #selector(signInWithGoogle) )
        googleView.isUserInteractionEnabled = true
        googleView.addGestureRecognizer(tap_2)
        
        let tap_3 = UITapGestureRecognizer(target: self, action: #selector(signInWithFacebook) )
        appleView.isUserInteractionEnabled = true
        appleView.addGestureRecognizer(tap_3)
    }
    
    @objc func signInWithGoogle(){
        print("Google")
        viewModel.Google_Login(_vc: self)
    }
    
    @objc func signInWithFacebook(){
        print("Facebook")
        let password = passwordTF.text ?? ""
        let email = emailTF.text ?? ""

    }
    
    @objc func signInWithApple(){
        print("Apple")
        let password = passwordTF.text ?? ""
        let email = emailTF.text ?? ""

    }
}
