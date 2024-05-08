//
//  Login_VC.swift
//  GoShop
//
//  Created by MAC on 10/12/2023.
//

import UIKit
import FBSDKLoginKit

class Login_VC: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var appleView: UIView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: - Variables
    
    var viewModel = LoginViewModel()
    
    //MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        hideKeyboardWhenTappedAround()
        setupSubViewsDesign()
        addActions()
    }
    
    //MARK: - IBActions
    
    @IBAction func loginBtn(_ sender: Any) {
        let email = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        if !(password.isEmpty ) &&
            !(email.isEmpty ){
            if (viewModel.isValidEmail(email) || viewModel.isValidPassword(password)){
                indicator.isHidden = false
                indicator.startAnimating()
                viewModel.Original_Login(password: password, email: email)
            }else{
                showToast(controller: self, message:ConstantStrings.NOT_VALID_DATA_TOAST, seconds: 1)
            }
        }else{
            showToast(controller: self, message:ConstantStrings.ENTER_ALL_FIELDS_TOAST, seconds: 1)
        }
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
        let tap_0 = UITapGestureRecognizer(target: self, action: #selector(goBack))
        backImg.isUserInteractionEnabled = true
        backImg.addGestureRecognizer(tap_0)
        
        let tap_1 = UITapGestureRecognizer(target: self, action: #selector(signInWithFacebook) )
        facebookView.isUserInteractionEnabled = true
        facebookView.addGestureRecognizer(tap_1)
        
        let tap_2 = UITapGestureRecognizer(target: self, action: #selector(signInWithGoogle) )
        googleView.isUserInteractionEnabled = true
        googleView.addGestureRecognizer(tap_2)
        
        let tap_3 = UITapGestureRecognizer(target: self, action: #selector(signInWithFacebook) )
        appleView.isUserInteractionEnabled = true
        appleView.addGestureRecognizer(tap_3)
    }
    
    @objc func goBack(){
        self.dismiss(animated: true)
    }
    @objc func signInWithGoogle(){
        print("Google")
        viewModel.Google_Login(_vc: self)
    }
    
    @objc func signInWithFacebook(){
        print("Facebook")
        // facebookLogin()
    }
    
    @objc func signInWithApple(){
        print("Apple")
    }
    
    func facebookLogin() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: self) { (result, error) in
            if let error = error {
                // Handle login error here
                print("Error: \(error.localizedDescription)")
            } else if let result = result, !result.isCancelled {
                // Login successful, you can access the user's Facebook data here
                self.fetchFacebookUserData()
            } else {
                // Login was canceled by the user
                print("Login was cancelled.")
            }
        }
    }
    
    // MARK: - Fetch Facebook User Data
    
    func fetchFacebookUserData() {
        if AccessToken.current != nil {
            // You can make a Graph API request here to fetch user data
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
                if let error = error {
                    // Handle API request error here
                    print("Error: \(error.localizedDescription)")
                } else if let userData = result as? [String: Any] {
                    // Access the user data here
                    let userID = userData["id"] as? String
                    let name = userData["name"] as? String
                    
                    // Handle the user data as needed
                    print("User ID: \(userID ?? "")")
                    print("Name: \(name ?? "")")
                    
                }
            }
        } else {
            print("No active Facebook access token.")
        }
    }
}
